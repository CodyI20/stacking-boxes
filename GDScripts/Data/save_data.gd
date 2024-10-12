extends Resource
class_name SaveData

@export var high_score := 0
const SAVE_PATH := "res://SaveFileTest/highscore_save_test.tres"

func save() -> void:
	ResourceSaver.save(self, SAVE_PATH)
	
static func load_or_create() -> SaveData:
	var res : SaveData
	if FileAccess.file_exists(SAVE_PATH):
		res = load(SAVE_PATH) as SaveData
	else:
		res = SaveData.new()
	return res
