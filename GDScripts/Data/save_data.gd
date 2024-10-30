extends Resource
class_name SaveData

@export var high_score := 0
@export var high_score_2 := 0
@export var high_score_3 := 0
@export var high_score_4 := 0
@export var high_score_5 := 0


const SAVE_PATH := "user://saves"
const HIGHSCORE_FILE_NAME := "high_score_save.tres"

func save() -> void:
	ResourceSaver.save(self, SAVE_PATH + HIGHSCORE_FILE_NAME)
	
static func load_or_create() -> SaveData:
	var res : SaveData
	if FileAccess.file_exists(SAVE_PATH + HIGHSCORE_FILE_NAME):
		res = load(SAVE_PATH + HIGHSCORE_FILE_NAME) as SaveData
	else:
		res = SaveData.new()
	return res
