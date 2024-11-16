extends Control

var saved_settings : SaveSettings

#region SOUND VARIABLES
# AUDIO BUS INDEXES
var MASTER_VOLUME_INDEX = AudioServer.get_bus_index("Master")
var MUSIC_VOLUME_INDEX = AudioServer.get_bus_index("Music")
var SFX_VOLUME_INDEX = AudioServer.get_bus_index("SFX")
#endregion

@export var resolutions: OptionButton
@export var window_modes: OptionButton
@export var v_sync: CheckButton
@export var master_slider: HSlider
@export var sfx_slider: HSlider
@export var music_slider: HSlider


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	saved_settings = SaveSettings.load_or_create()
	Events.options_menu_toggle.connect(toggle_menu)
	set_saved_settings()
	toggle_menu(false)
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Esc"):
		Utility.toggle_options_menu(false)
	
func set_saved_settings() -> void:
	# RESOLUTION
	DisplayServer.window_set_size(saved_settings.resolution)
	resolutions.selected = saved_settings.resolution_index
	# WINDOW MODE
	window_mode_setter(saved_settings.window_mode_index)
	window_modes.selected = saved_settings.window_mode_index
	# V-SYNC
	DisplayServer.window_set_vsync_mode(saved_settings.v_sync)
	v_sync.button_pressed = saved_settings.v_sync_bool
	# MASTER VOLUME
	AudioServer.set_bus_volume_db(MASTER_VOLUME_INDEX, linear2db(clamp(saved_settings.master_volume/100, 0.0, 1.0)))
	master_slider.value = saved_settings.master_volume
	# MUSIC VOLUME
	AudioServer.set_bus_volume_db(MUSIC_VOLUME_INDEX, linear2db(clamp(saved_settings.music_volume/100, 0.0, 1.0)))
	music_slider.value = saved_settings.music_volume
	# SFX VOLUME
	AudioServer.set_bus_volume_db(SFX_VOLUME_INDEX, linear2db(clamp(saved_settings.sfx_volume/100, 0.0, 1.0)))
	sfx_slider.value = saved_settings.sfx_volume

func toggle_menu(enabled: bool) -> void:
	visible = enabled
	set_process(enabled)

#region VIDEO SETTINGS
func _on_resolutions_item_selected(index: int) -> void:
	var res_vector = Vector2i(1280,720) # Safe guard default resolution
	match index:
		0:
			res_vector = Vector2i(2560,1440)
		1:
			res_vector = Vector2i(1920,1080)
		2:
			res_vector = Vector2i(1280,720)
		3:
			res_vector = Vector2i(1024,768)
	
	DisplayServer.window_set_size(res_vector)
	
	saved_settings.resolution = res_vector
	saved_settings.resolution_index = index
	saved_settings.save()

func _on_window_modes_item_selected(index: int) -> void:
	window_mode_setter(index)

func window_mode_setter(index : int) -> void:
	var window_mode = DisplayServer.WINDOW_MODE_WINDOWED # Safe guard default value
	match index:
		0:
			window_mode = DisplayServer.WINDOW_MODE_FULLSCREEN
		1:
			window_mode = DisplayServer.WINDOW_MODE_WINDOWED
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		2:
			window_mode = DisplayServer.WINDOW_MODE_WINDOWED
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
	
	DisplayServer.window_set_mode(window_mode)
	DisplayServer.window_set_size(saved_settings.resolution)
	
	saved_settings.window_mode = window_mode
	saved_settings.window_mode_index = index
	saved_settings.save()

func _on_vsync_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
		saved_settings.v_sync = DisplayServer.VSYNC_ENABLED
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		saved_settings.v_sync = DisplayServer.VSYNC_DISABLED
	saved_settings.v_sync_bool = toggled_on
	saved_settings.save()
#endregion
#region SOUND SETTINGS

func change_volume_db(index: int, input_value: float) -> void:
	var volume = clamp(input_value/100, 0.0, 1.0)
	AudioServer.set_bus_volume_db(index, linear2db(volume))

func _on_master_slider_value_changed(value: float) -> void:
	saved_settings.master_volume = value
	saved_settings.save()
	change_volume_db(MASTER_VOLUME_INDEX, value)

func _on_sfx_slider_value_changed(value: float) -> void:
	saved_settings.sfx_volume = value
	saved_settings.save()
	change_volume_db(SFX_VOLUME_INDEX, value)
	
func _on_sfx_slider_drag_ended(value_changed: bool) -> void:
	Events.sfx_slider_value_set.emit()

func _on_music_slider_value_changed(value: float) -> void:
	saved_settings.music_volume = value
	saved_settings.save()
	change_volume_db(MUSIC_VOLUME_INDEX, value)
	
# Utility function to convert linear volume to decibels
func linear2db(linear: float) -> float:
	return 20.0 * log(max(linear, 0.0001)) / log(10.0)
	
#endregion
#region BUTTONS
func _on_back_button_pressed() -> void:
	Events.options_menu_toggle.emit(false)
	
func _on_menu_button_pressed() -> void:
	Utility.go_to_main_menu()

func _on_quit_button_pressed() -> void:
	Utility.quit_game()
#endregion
