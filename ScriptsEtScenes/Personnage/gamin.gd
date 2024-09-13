extends Sprite3D

@export var perso : Node3D
@onready var player = null

@onready var audio_hey = $AudioStreamPlayer3D

var interact = {
	"demande_bonbon" : "Si tu me donnes un truc sucré, jte file peut être un indice sur un insecte rare !",
	"demande_fossile" : "Si tu me donnes un caillou chelou, jte file l'indice.",
	"donne_info" : "Le scarabé brillant se trouve par là.",
	"dr_bug" : "Tu l'as trouvé ! Bien joué docteur bug !"
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
		return [interact["demande_bonbon"], ""]
	elif !player.fossile:
		return [interact["demande_fossile"], "donne_bonbon"]
	elif !player.shiny:
		return [interact["donne_info"], "donne_fossile"]
	else:
		return [interact["dr_bug"], ""]

func play_hey():
	audio_hey.play()
