extends Resource
class_name SaveSettings

# SETTINGS
@export var resolution := Vector2i(1280,720)
@export var resolution_index := 1
@export var window_mode := DisplayServer.WINDOW_MODE_WINDOWED
@export var window_mode_index := 1
@export var v_sync := DisplayServer.VSYNC_DISABLED
@export var v_sync_bool := false
@export var master_volume := 100
@export var music_volume := 100
@export var sfx_volume := 100

const SAVE_PATH := "user://"
const SETTINGS_FILE_NAME := "settings.tres"


func save() -> void:
	ResourceSaver.save(self, SAVE_PATH + SETTINGS_FILE_NAME)
	
static func load_or_create() -> SaveSettings:
	var res : SaveSettings
	if FileAccess.file_exists(SAVE_PATH + SETTINGS_FILE_NAME):
		res = load(SAVE_PATH + SETTINGS_FILE_NAME) as SaveSettings
	else:
		res = SaveSettings.new()
	return res
