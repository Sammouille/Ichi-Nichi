extends CanvasLayer

@onready var vboxbutton = $VBoxButton
@onready var vboxcredits = $VBoxCredits
@onready var options = $Options

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_play_pressed() -> void:
	pass # Replace with function body.


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
