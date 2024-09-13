extends AnimationPlayer


var matinee = true



func _ready():
	play("matinee", -1, 0.1)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if matinee :
		matinee = false
		_lancer_anim_aprem()

func _lancer_anim_aprem():
	if is_playing() :
		stop()
	play("transition_midi")
	await animation_finished
	play("aprem", -1, 0.1)



func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("DEBUG_a_table_midi"):
		if is_playing():
			stop()
		play("matinee")
		seek(14.9)
	if Input.is_action_just_pressed("DEBUG_a_table_diner"):
		if is_playing():
			stop()
		play("aprem")
		seek(14.9)
		
