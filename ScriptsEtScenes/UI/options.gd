extends CanvasLayer

@onready var vboxoptions = $VBoxOptions
@onready var showinput = $ShowInput

@onready var keyboardinput = $ShowInput/KeyboardInput
@onready var controllerinput = $ShowInput/ControllerInput

@onready var button_quit = $VBoxOptions/VBoxButton/ButtonQuit

@onready var button_controls = $VBoxOptions/ButtonControls
@onready var button_controller = $ShowInput/VBoxButtonInput/ButtonController

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button_controls.grab_focus()
	
	if get_tree().current_scene.name == "TiersLieux" :
		button_quit.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_back_pressed() -> void:
	self.visible = false


func _on_button_quit_pressed() -> void:
	get_tree().quit()


func _on_button_fullscreen_pressed() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)


func _on_button_windowed_pressed() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_button_controls_pressed() -> void:
	vboxoptions.visible = false
	showinput.visible = true
	button_controller.grab_focus()

func _on_button_back_control_pressed() -> void:
	vboxoptions.visible = true
	showinput.visible = false
	button_controls.grab_focus()


func _on_button_controller_pressed() -> void:
	controllerinput.visible = true
	keyboardinput.visible = false


func _on_button_keyboard_pressed() -> void:
	controllerinput.visible = false
	keyboardinput.visible = true


func _on_visibility_changed() -> void:
	#if self.visible:
		#button_controls.grab_focus()
	pass
