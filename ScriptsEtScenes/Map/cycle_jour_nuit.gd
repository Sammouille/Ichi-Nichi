extends Node3D

@onready var anim_player : AnimationPlayer = get_child(0)

func _passer_midi():
	anim_player._lancer_anim_aprem()
	$AreaAllerManger.heure_manger = false
	
func _heure_manger():
	$ATable.play()
	$AreaAllerManger.heure_manger = true
