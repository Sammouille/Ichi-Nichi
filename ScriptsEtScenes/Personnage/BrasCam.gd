extends Node

@export var cam_vitesse : float = 2
@export var min_hauteur : float
@export var max_hauteur : float

var hauteur

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var rot : Vector3
	var event = Input
	
	rot = get_parent().get_third_person_rotation()
	hauteur = rot.x
	
	if event.is_action_pressed("rotation_cam_haut") && rot.x > min_hauteur :
		rot.x -= event.get_action_strength("rotation_cam_haut") * cam_vitesse * delta
	if event.is_action_pressed("rotation_cam_bas") && rot.x < max_hauteur :
		rot.x += event.get_action_strength("rotation_cam_bas") * cam_vitesse * delta
	if event.is_action_pressed("rotation_cam_droite"):
		rot.y += event.get_action_strength("rotation_cam_droite") * cam_vitesse * delta
	if event.is_action_pressed("rotation_cam_gauche"):
		rot.y -= event.get_action_strength("rotation_cam_gauche") * cam_vitesse * delta
	
	get_parent().set_third_person_rotation(rot)
