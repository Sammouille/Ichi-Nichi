extends Node3D

@onready var menu = $Menu
@onready var hudlivre = $HUDLivre

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Pause"):
		if hudlivre.visible:
			hudlivre.visible = false
		else:
			menu.visible = !menu.visible

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_menu_show_book() -> void:
	hudlivre.visible = true
