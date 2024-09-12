extends CharacterBody3D

@export var pcam : PhantomCamera3D

@onready var dialog = $Dialog
@onready var label_dialog = $Dialog/Background/LabelDialogPNJ

@onready var texture_bonbon = $Object/HBoxObject/bonbon
@onready var texture_poupee = $Object/HBoxObject/poupee
@onready var texture_lanterne = $Object/HBoxObject/lanterne
@onready var texture_fossile = $Object/HBoxObject/fossile

var orientation_pcam : float

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

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
			lanterne_cassee = false
			texture_lanterne.modulate = Color.WHITE
		
		if tmp[1] == "donne_bonbon":
			print("dfs")
			texture_bonbon.visible = false
		
		if tmp[1] == "donne_fossile":
			texture_fossile.visible = false
		
		if tmp[1] == "donne_poupee":
			texture_poupee.visible = false
	
	if Input.is_action_just_released("Interact") and collectible_in_range != null:
		if collectible_in_range.name == "Poupee":
			poupee = true
			texture_poupee.visible = true
			collectible_in_range.queue_free()
			collectible_in_range = null
		
		elif collectible_in_range.name == "LanterneCassee":
			lanterne_cassee = true
			texture_lanterne.visible = true
			texture_lanterne.modulate = Color.RED
			collectible_in_range.queue_free()
			collectible_in_range = null
		
		elif collectible_in_range.name == "Fossile":
			fossile = true
			texture_fossile.visible = true
			collectible_in_range.queue_free()
			collectible_in_range = null		
		
		
		elif collectible_in_range.name == "Criquet":
			criquet = true
			emit_signal("criquet_obtained")
			collectible_in_range.queue_free()
			collectible_in_range = null
		
		elif collectible_in_range.name == "Scarabe":
			scarabe = true
			emit_signal("scarabe_obtained")
			collectible_in_range.queue_free()
			collectible_in_range = null
		
		elif collectible_in_range.name == "Luciole":
			luciole = true
			emit_signal("luciole_obtained")
			collectible_in_range.queue_free()
			collectible_in_range = null
		
		elif collectible_in_range.name == "Shiny":
			shiny = true
			emit_signal("shiny_obtained")
			collectible_in_range.queue_free()
			collectible_in_range = null
	
	
	if ( Input.is_action_just_pressed("manette_retour_menu") or Input.is_action_just_pressed("Pause") ) and dialog.visible:
		dialog.visible = false


func _physics_process(delta: float) -> void:
	
	orientation_pcam = pcam.global_rotation.y
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("bouger_gauche", "bouger_droite", "bouger_avant", "bouger_arriere")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized().rotated(Vector3.UP, orientation_pcam)
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func _on_area_detect_pnj_area_entered(area: Area3D) -> void:
	if area.get_parent().is_in_group("PNJ"):
		pnj_in_range = area.get_parent()
	
	if area.get_parent().is_in_group("Collectible"):
		collectible_in_range = area.get_parent()


func _on_area_detect_pnj_area_exited(area: Area3D) -> void:
	if area.get_parent().is_in_group("PNJ"):
		pnj_in_range = null
		dialog.visible = false
	
	if area.get_parent().is_in_group("Collectible"):
		collectible_in_range = null
