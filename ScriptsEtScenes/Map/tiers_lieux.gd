extends Node3D

@onready var menu = $Menu
@onready var hudlivre = $HUDLivre

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Pause"):
		if hudlivre.visible:
			hudlivre.visible = false
			get_tree().paused = false
		else:
			menu.esc_hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_menu_show_book() -> void:
	hudlivre.visible = true
	get_tree().paused = true
	set_process_input(true)
