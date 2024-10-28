extends Control

#region SOUND VARIABLES
# AUDIO BUS INDEXES
var MASTER_VOLUME_INDEX = AudioServer.get_bus_index("Master")
var MUSIC_VOLUME_INDEX = AudioServer.get_bus_index("Music")
var SFX_VOLUME_INDEX = AudioServer.get_bus_index("SFX")
#endregion

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.options_menu_toggle.connect(toggle_menu)
	toggle_menu(false)

func toggle_menu(enabled: bool) -> void:
	visible = enabled
	set_process(enabled)

#region RESOLUTION SETTINGS
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
#endregion
#region SOUND SETTINGS

func change_volume_db(index: int, input_value: float) -> void:
	var volume = clamp(input_value/100, 0.0, 1.0)
	AudioServer.set_bus_volume_db(index, linear2db(volume))

func _on_master_slider_value_changed(value: float) -> void:
	change_volume_db(MASTER_VOLUME_INDEX, value)

func _on_sfx_slider_value_changed(value: float) -> void:
	change_volume_db(SFX_VOLUME_INDEX, value)

func _on_music_slider_value_changed(value: float) -> void:
	change_volume_db(MUSIC_VOLUME_INDEX, value)
	
# Utility function to convert linear volume to decibels
func linear2db(linear: float) -> float:
	return 20.0 * log(max(linear, 0.0001)) / log(10.0)
	
#endregion
#region BUTTONS
func _on_back_button_pressed() -> void:
	Events.options_menu_toggle.emit(false)

func _on_quit_button_pressed() -> void:
	GameManager.quit_game()
#endregion
