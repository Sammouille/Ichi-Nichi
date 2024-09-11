extends CanvasLayer

@onready var vboxbutton = $VBoxButton
@onready var vboxcredits = $VBoxCredits
@onready var options = $Options

@onready var button_livre = $VBoxButton/ButtonLivre

signal show_book

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if get_tree().current_scene.name == "TiersLieux":
		button_livre.visible = true


#func _input(event: InputEvent) -> void:
	#if Input.is_action_just_pressed("Pause") and get_tree().current_scene.name == "TiersLieux" :
		#self.visible = !self.visible

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_play_pressed() -> void:
	if get_tree().current_scene.name == "TiersLieux" :
		self.visible = false


func _on_button_option_pressed() -> void:
	options.visible = true
	vboxbutton.visible = false


func _on_button_credits_pressed() -> void:
	vboxcredits.visible = true
	vboxbutton.visible = false


func _on_button_quit_pressed() -> void:
	get_tree().quit()


func _on_button_back_pressed() -> void:
	vboxcredits.visible = false
	vboxbutton.visible = true


func _on_options_visibility_changed() -> void:
	vboxbutton.visible = true


func _on_button_livre_pressed() -> void:
	emit_signal("show_book")


func _on_visibility_changed() -> void:
	if options != null:
		options.visible = false
