extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.options_menu_toggle.connect(toggle_menu)
	toggle_menu(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# RESOLUTION SETTINGS
func _on_resolutions_item_selected(index: int) -> void:
	var res_vector = Vector2i(1920,1080) # Safe guard default resolution
	match index:
		0:
			res_vector = Vector2i(1920,1080)
		1:
			res_vector = Vector2i(1280,720)
	
	DisplayServer.window_set_size(res_vector)


func _on_window_modes_item_selected(index: int) -> void:
	var window_mode = DisplayServer.WINDOW_MODE_WINDOWED # Safe guard default value
	match index:
		0:
			window_mode = DisplayServer.WINDOW_MODE_FULLSCREEN
		1:
			DisplayServer.WINDOW_MODE_WINDOWED
	
	DisplayServer.window_set_mode(window_mode)

func toggle_menu(enabled: bool) -> void:
	visible = enabled
	set_process(enabled)

# BUTTONS
func _on_back_button_pressed() -> void:
	Events.options_menu_toggle.emit(false)


func _on_quit_button_pressed() -> void:
	GameManager.quit_game()
