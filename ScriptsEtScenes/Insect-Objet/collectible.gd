extends Sprite3D

@export var perso : Node3D
@onready var player = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = perso.get_children()[1]


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	self.look_at(player.global_position)
