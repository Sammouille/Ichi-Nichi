extends CharacterBody3D

@export var pcam : PhantomCamera3D

@onready var dialog = $Dialog
@onready var label_dialog = $Dialog/Background/LabelDialogPNJ

@onready var texture_bonbon = $Object/HBoxObject/bonbon
@onready var texture_poupee = $Object/HBoxObject/poupee
@onready var texture_lanterne = $Object/HBoxObject/lanterne
@onready var texture_fossile = $Object/HBoxObject/fossile

@onready var indic_interact = $Object/IndicInteract

@onready var notif_livre = $Object/LivreInfo/Notif

@onready var cpu_particles = $CPUParticles3D

@onready var bruit_de_pas = $BruitDePas

var orientation_pcam : float

const BASE_SPEED = 1
const JUMP_VELOCITY = 11
const MAX_SPEED = 7

var vitesse = BASE_SPEED
var input_dir : Vector2
var sprint = false
var direction 

var peut_manger = false

var pnj_in_range = null
var collectible_in_range = null

var bonbon = false
var poupee = false
var lanterne_cassee = false
var lanterne = false
var fossile = false

var scarabe = false
var luciole = false
var criquet = false
var shiny = false
var chaise = true

var new_insect_to_see = false

@warning_ignore("unused_signal")
signal criquet_obtained
@warning_ignore("unused_signal")
signal scarabe_obtained
@warning_ignore("unused_signal")
signal luciole_obtained
@warning_ignore("unused_signal")
signal shiny_obtained

@warning_ignore("unused_parameter")
func _input(event: InputEvent) -> void:
	if Input.is_action_just_released("Interact") and pnj_in_range != null:
		var tmp = pnj_in_range.send_text()
		label_dialog.text = tmp[0]
		dialog.visible = true
		
		if tmp[1] == "bonbon":
			bonbon = true
			texture_bonbon.visible = true
		
		if tmp[1] == "lanterne":
			lanterne = true
			get_parent()._allumer_lanterne()
			lanterne_cassee = false
			texture_lanterne.modulate = Color.WHITE
		
		if tmp[1] == "donne_bonbon":
			texture_bonbon.visible = false
		
		if tmp[1] == "donne_fossile":
			texture_fossile.visible = false
		
		if tmp[1] == "donne_poupee":
			texture_poupee.visible = false
	
	if Input.is_action_just_released("Interact") and collectible_in_range != null:
		if collectible_in_range.name == "Poupee":
			poupee = true
			texture_poupee.visible = true
			particle_catch()
			collectible_in_range.queue_free()
			collectible_in_range = null
		
		elif collectible_in_range.name == "LanterneCassee":
			lanterne_cassee = true
			texture_lanterne.visible = true
			texture_lanterne.modulate = Color.RED
			particle_catch()
			collectible_in_range.queue_free()
			collectible_in_range = null
		
		elif collectible_in_range.name == "Fossile":
			fossile = true
			texture_fossile.visible = true
			particle_catch()
			collectible_in_range.queue_free()
			collectible_in_range = null
		
		
		elif collectible_in_range.name == "Criquet":
			criquet = true
			emit_signal("criquet_obtained")
			particle_catch()
			collectible_in_range.queue_free()
			collectible_in_range = null
			new_insect()
		
		elif collectible_in_range.name == "Scarabe":
			scarabe = true
			emit_signal("scarabe_obtained")
			particle_catch()
			collectible_in_range.queue_free()
			collectible_in_range = null
			new_insect()
		
		elif collectible_in_range.name == "Luciole":
			luciole = true
			emit_signal("luciole_obtained")
			particle_catch()
			collectible_in_range.queue_free()
			collectible_in_range = null
			new_insect()
		
		elif collectible_in_range.name == "Shiny":
			shiny = true
			emit_signal("shiny_obtained")
			particle_catch()
			collectible_in_range.queue_free()
			collectible_in_range = null
			new_insect()
	
	if Input.is_action_just_released("Interact") and peut_manger:
		get_parent()._va_manger()
	
	if ( Input.is_action_just_pressed("manette_retour_menu") or Input.is_action_just_pressed("Pause") ) and dialog.visible:
		dialog.visible = false

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("Sprint"):
		if not is_on_floor() :
			await is_on_floor()
		sprint = true
	if Input.is_action_just_released("Sprint"):
		if not is_on_floor() :
			await is_on_floor()
		sprint = false
		
	if Input.is_action_just_pressed("ui_accept"):
		lanterne = true
	

func _physics_process(delta: float) -> void:
	
	if is_on_floor() :
		if sprint :
			vitesse += (BASE_SPEED + clampf((Input.get_action_strength("bouger_arriere") + Input.get_action_strength("bouger_avant") + Input.get_action_strength("bouger_droite") + Input.get_action_strength("bouger_gauche")), 0, 1))*0.3
			vitesse = clampf(vitesse, 0, MAX_SPEED)
		
		else : 
			vitesse = BASE_SPEED + clampf((Input.get_action_strength("bouger_arriere") + Input.get_action_strength("bouger_avant") + Input.get_action_strength("bouger_droite") + Input.get_action_strength("bouger_gauche")), 0, 1) * 3
		
		if vitesse > 1 :
			if not bruit_de_pas.playing :
				bruit_de_pas.play()
		else :
			bruit_de_pas.stop()
	
	elif sprint :
		vitesse += (4/3) * vitesse
		vitesse = clampf(vitesse, 0, MAX_SPEED * 1.1)
		
	else :
		bruit_de_pas.stop()
	
	
	orientation_pcam = pcam.global_rotation.y
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * 4

	# Handle jump.
	if Input.is_action_just_pressed("Saut") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if is_on_floor():
		input_dir = Input.get_vector("bouger_gauche", "bouger_droite", "bouger_avant", "bouger_arriere")
		direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized().rotated(Vector3.UP, orientation_pcam)
	if direction:
		velocity.x = direction.x * vitesse
		velocity.z = direction.z * vitesse
	else:
		velocity.x = move_toward(velocity.x, 0, vitesse)
		velocity.z = move_toward(velocity.z, 0, vitesse)

	move_and_slide()



func _on_area_detect_pnj_area_entered(area: Area3D) -> void:
	if area.get_parent().is_in_group("PNJ"):
		pnj_in_range = area.get_parent()
		indic_interact.visible = true
	
	if area.get_parent().is_in_group("Collectible"):
		collectible_in_range = area.get_parent()
		indic_interact.visible = true


func _on_area_detect_pnj_area_exited(area: Area3D) -> void:
	if area.get_parent().is_in_group("PNJ"):
		pnj_in_range = null
		dialog.visible = false
		indic_interact.visible = false
	
	if area.get_parent().is_in_group("Collectible"):
		collectible_in_range = null
		indic_interact.visible = false


func new_insect():
	new_insect_to_see = true
	notif_livre.visible = true


func _on_hud_livre_open_livre() -> void:
	new_insect_to_see = false
	notif_livre.visible = false


func particle_catch():
	cpu_particles.global_position = collectible_in_range.global_position
	cpu_particles.emitting = true
