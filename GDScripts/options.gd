extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


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


# BUTTONS
func _on_back_button_pressed() -> void:
	visible = false
	set_process(false)


func _on_quit_button_pressed() -> void:
	GameManager.quit_game()
