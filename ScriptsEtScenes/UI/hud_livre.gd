extends CanvasLayer

@onready var preload_texture_livre_shiny = preload("res://Assets/2D/livre_shiny.png")

@onready var texture_livre = $Livre

@onready var scarabe_dore = $Scarabe_dore
@onready var criquet = $Criquet
@onready var scarabe = $Scarabe
@onready var luciole = $Luciole
@onready var chaise = $Chaise

@onready var button_back = $ButtonBack


@warning_ignore("unused_signal")
signal hiding_livre

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button_back.grab_focus()
	chaise_obtained()


@warning_ignore("unused_parameter")
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("manette_accept_ui") and self.visible:
		#print(get_viewport().gui_get_focus_owner())
		get_viewport().gui_get_focus_owner().emit_signal("pressed")
	
	if Input.is_action_just_pressed("manette_retour_menu") and self.visible:
		self.visible = false
		emit_signal("hiding_livre")
	
	#if Input.is_action_just_pressed("ui_left"):
		#if !criquet.visible :
			#criquet_obtained()
		#elif !scarabe.visible :
			#scarabe_obtained()
		#elif !luciole.visible:
			#luciole_obtained()
		#elif !chaise.visible:
			#chaise_obtained()
		#elif !scarabe_dore.visible:
			#shiny_obtained()
	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass


func criquet_obtained():
	criquet.visible = true


func scarabe_obtained():
	scarabe.visible = true


func luciole_obtained():
	luciole.visible = true


func chaise_obtained():
	chaise.visible = true


func shiny_obtained():
	texture_livre.texture = preload_texture_livre_shiny
	scarabe_dore.visible = true


func _on_button_back_pressed() -> void:
	self.visible = false
	emit_signal("hiding_livre")

func _on_visibility_changed() -> void:
	if self.visible:
		button_back.grab_focus()
