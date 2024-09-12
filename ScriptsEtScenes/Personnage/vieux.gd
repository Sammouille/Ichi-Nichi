extends Sprite3D

@export var perso : Node3D
@onready var player = null

var interact = {
	"dr_chen" : "Sache que plus un criquet est vieux, plus il est vif !",
	"indice_poupee" : "Tu as du trouvé ce criquet aux alentours de la vieille usine. Tu pourrais y trouver un ancien objet qui appartenait à la dame qui est si gentille avec vous.",
	"lanterne_cassee" : "Laisse moi te réparer cette vieille lanterne. Elle pourra te guider dans les lieux sombre.",
	"encore" : "Il doit te rester des choses à découvrir par ici.",
	"journee" : "Je vois que tu as passé une bonne journée. Cela te fera de bons souvenirs sur lesquels être nostalgique. Et peut être que ceux ci te permettront de créer de grandes choses."
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	player = perso.get_children()[1]


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	self.look_at(player.global_position)


func send_text():
	if player.lanterne_cassee:
		return [interact["lanterne_cassee"], "lanterne"]
	elif !player.criquet:
		return [interact["dr_chen"], ""]
	elif !player.poupee:
		return [interact["indice_poupee"], ""]
	
	elif player.criquet and player.scarabe and player.shiny and player.luciole and player.lanterne and player.poupee and player.fossile and player.bonbon:
		return [interact["journee"], ""]
	else:
		return [interact["encore"], ""]
	
