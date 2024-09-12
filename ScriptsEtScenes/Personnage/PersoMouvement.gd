extends RigidBody3D

var input_deplacement : Vector3

var velocite : Vector3


#var 

@export var pcam : PhantomCamera3D

func _unhandled_input(event: InputEvent) -> void:

	if event.is_action("bouger_avant") or event.is_action("bouger_arriere") or event.is_action("bouger_gauche") or event.is_action("bouger_droite"):
		input_deplacement.z = Input.get_action_strength("bouger_arriere") - Input.get_action_strength("bouger_avant")
		input_deplacement.x = Input.get_action_strength("bouger_droite") - Input.get_action_strength("bouger_gauche")
		print("Mouvement Avant/Arriere : " + str(input_deplacement.x))
		print("Mouvement Gauche/Droite : " + str(input_deplacement.z))
		
		var orientation_cam = pcam.global_rotation.y
		
		input_deplacement = input_deplacement.rotated(Vector3.UP, orientation_cam)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocite = delta * input_deplacement
	position += velocite
