extends CanvasLayer

@onready var vboxbutton = $VBoxButton
@onready var vboxcredits = $VBoxCredits
@onready var options = $Options

@onready var button_livre = $VBoxButton/ButtonLivre
@onready var button_play = $VBoxButton/ButtonPlay
@onready var button_option = $VBoxButton/ButtonOption
@onready var button_credits =$VBoxButton/ButtonCredits
@onready var button_backcredits = $VBoxCredits/ButtonBack

@onready var button_option_control = $Options/VBoxOptions/ButtonControls

var book_show = false

signal show_book

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button_play.grab_focus()
	
	if get_tree().current_scene.name == "TiersLieux":
		button_livre.visible = true
		button_play.focus_neighbor_bottom = button_livre.get_path()
		button_option.focus_neighbor_top = button_livre.get_path()


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Pause") and get_tree().current_scene.name == "Menu" :
		esc_hide()
	
	if Input.is_action_just_pressed("manette_accept_ui") and self.visible:
		#print(get_viewport().gui_get_focus_owner())
		get_viewport().gui_get_focus_owner().emit_signal("pressed")
	
	if Input.is_action_just_pressed("manette_retour_menu"):
		
		if self.visible and get_tree().current_scene.name == "TiersLieux" and !vboxcredits.visible and !options.visible and !book_show and vboxbutton.visible:
			self.visible = false
			get_tree().paused = false
		
		if vboxcredits.visible:
			vboxcredits.visible = false
			vboxbutton.visible = true
			button_credits.grab_focus()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_play_pressed() -> void:
	if get_tree().current_scene.name == "TiersLieux" :
		self.visible = false
		get_tree().paused = false
	else:
		get_tree().change_scene_to_file("res://ScriptsEtScenes/Map/tiers_lieux.tscn")


func _on_button_option_pressed() -> void:
	options.visible = true
	vboxbutton.visible = false
	button_option_control.grab_focus()


func _on_button_credits_pressed() -> void:
	vboxcredits.visible = true
	vboxbutton.visible = false
	button_backcredits.grab_focus()


func _on_button_quit_pressed() -> void:
	if get_tree().current_scene.name == "Menu":
		get_tree().quit()
	else:
		get_tree().change_scene_to_file("res://ScriptsEtScenes/UI/menu.tscn")


func _on_button_back_pressed() -> void:
	vboxcredits.visible = false
	vboxbutton.visible = true
	button_credits.grab_focus()


func _on_options_visibility_changed() -> void:
	vboxbutton.visible = true
	button_option.grab_focus()


func _on_button_livre_pressed() -> void:
	emit_signal("show_book")
	book_show = true


func _on_visibility_changed() -> void:
	if self.visible:
		button_play.grab_focus()
	
	if options != null:
		options.visible = false


func _on_hud_livre_hiding_livre() -> void:
	button_play.grab_focus()
	book_show = false


func esc_hide():
	if !self.visible:
		self.visible = true
		get_tree().paused = true
		set_process_input(true)
	
	elif options.visible:
		options.visible = false
		button_option.grab_focus()
	
	elif vboxcredits.visible:
		vboxcredits.visible = false
		vboxbutton.visible = true
		button_credits.grab_focus()
	
	else:
		if get_tree().current_scene.name == "TiersLieux":
			self.visible = false
			get_tree().paused = false
			
