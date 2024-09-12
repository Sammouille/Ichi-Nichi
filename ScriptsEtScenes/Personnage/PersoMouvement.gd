extends RigidBody3D

var input_deplacement : Vector3

var velocite : Vector3

var min_yaw : float = 0
var max_yaw : float = 360

var min_pitch : float = -89.9
var max_pitch : float = 50

@export var pcam : PhantomCamera3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _unhandled_input(event: InputEvent) -> void:

	if event.is_action("bouger_avant") or event.is_action("bouger_arriere") or event.is_action("bouger_gauche") or event.is_action("bouger_droite"):
		input_deplacement.x = Input.get_action_strength("bouger_avant") - Input.get_action_strength("bouger_arriere")
		input_deplacement.z = Input.get_action_strength("bouger_droite") - Input.get_action_strength("bouger_gauche")
		print("Mouvement Avant/Arriere : " + str(input_deplacement.x))
		print("Mouvement Gauche/Droite : " + str(input_deplacement.z))
	#if event.is_action("bouger_avant"):
	
	#if event.is_action("rotation_cam_haut") or event.is_action("rotation_cam_bas") or event.is_action("rotation_cam_gauche") or event.is_action("rotation_cam_droite"):
	#
	##if Input.get_joy_axis(0, JOY_AXIS_RIGHT_X) or Input.get_joy_axis(0,JOY_AXIS_RIGHT_Y) :
		#var pcam_rotation : Vector3
		#
		#
		#
		#pcam_rotation = pcam.get_third_person_rotation_degrees()
		#
		#pcam_rotation.z -= Input.get_action_strength("rotation_cam_haut") - Input.get_action_strength("rotation_cam_bas")
		#pcam_rotation.y -= Input.get_action_strength("rotation_cam_droite") - Input.get_action_strength("rotation_cam_gauche")
		#
		##pcam_rotation.z -= Input.get_joy_axis(0,JOY_AXIS_LEFT_Y)
		#pcam_rotation.z = clampf(pcam_rotation.z, min_pitch, max_pitch)
		#
		##pcam_rotation.y -= Input.get_joy_axis(0,JOY_AXIS_LEFT_X)
		#pcam_rotation.y = clampf(pcam_rotation.y, min_yaw, max_yaw)
		#
		#pcam.set_third_person_rotation_degrees(pcam_rotation)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocite = delta * input_deplacement
	position += velocite
