extends Node3D

signal criquet_obtained
signal scarabe_obtained
signal luciole_obtained
signal shiny_obtained

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_character_body_3d_criquet_obtained() -> void:
	emit_signal("criquet_obtained")


func _on_character_body_3d_luciole_obtained() -> void:
	emit_signal("luciole_obtained")


func _on_character_body_3d_scarabe_obtained() -> void:
	emit_signal("scarabe_obtained")


func _on_character_body_3d_shiny_obtained() -> void:
	emit_signal("shiny_obtained")
