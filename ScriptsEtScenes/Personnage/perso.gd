extends Node3D

signal criquet_obtained
signal scarabe_obtained
signal luciole_obtained
signal shiny_obtained
signal chaise_obtained

var flip_flop_lanterne = false



@export var lumiere_lanterne : Node

@onready var cycle : Node3D = $"../CycleJourNuit"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _va_manger():
	cycle._passer_midi()


func _on_character_body_3d_criquet_obtained() -> void:
	emit_signal("criquet_obtained")


func _on_character_body_3d_luciole_obtained() -> void:
	emit_signal("luciole_obtained")


func _on_character_body_3d_scarabe_obtained() -> void:
	emit_signal("scarabe_obtained")


func _on_character_body_3d_shiny_obtained() -> void:
	emit_signal("shiny_obtained")

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("allumer_lanterne") and $CharacterBody3D.lanterne and lumiere_lanterne :
		if not flip_flop_lanterne :
			flip_flop_lanterne = true
			lumiere_lanterne.show()
		else :
			flip_flop_lanterne = false
			lumiere_lanterne.hide()


func _on_character_body_3d_chaise_obtained() -> void:
	emit_signal("chaise_obtained")
