extends CharacterBody3D

@export var pcam : PhantomCamera3D

var orientation_pcam : float

const BASE_SPEED = 1.5
const JUMP_VELOCITY = 4.5

var vitesse = BASE_SPEED

func _physics_process(delta: float) -> void:
	
	orientation_pcam = pcam.global_rotation.y
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Saut") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("bouger_gauche", "bouger_droite", "bouger_avant", "bouger_arriere")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized().rotated(Vector3.UP, orientation_pcam)
	if direction:
		velocity.x = direction.x * vitesse
		velocity.z = direction.z * vitesse
	else:
		velocity.x = move_toward(velocity.x, 0, vitesse)
		velocity.z = move_toward(velocity.z, 0, vitesse)

	move_and_slide()

func _unhandled_input(_event: InputEvent) -> void:
	#if event.is_action("bouger_avant") or event.is_action("bouger_arriere") or event.is_action("bouger_gauche") or event.is_action("bouger_droite"):
		vitesse = BASE_SPEED + (Input.get_action_strength("bouger_arriere") + Input.get_action_strength("bouger_avant") + Input.get_action_strength("bouger_droite") + Input.get_action_strength("bouger_gauche")) * 3
