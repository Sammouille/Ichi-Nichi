extends Sprite3D

@export var perso : Node3D
@onready var player = null

@onready var audio_hey = $AudioStreamPlayer3D

var interact = {
	"pas_bonbon" : "Tiens bonbon",
	"pas_poupee" : "Belle journée",
	"poupee" : "Merci beaucoup UwU"
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = perso.get_children()[1]


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	self.look_at(player.global_position)


func send_text():
	if !player.bonbon:
		return [interact["pas_bonbon"], "bonbon"]
	elif !player.poupee:
		return [interact["pas_poupee"], ""]
	else:
		return [interact["poupee"], "donne_poupee"]
	
	@warning_ignore("unreachable_code")
	return "erreur texte nullos"

func play_hey():
	audio_hey.play()
