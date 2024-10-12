extends Node

var current_score := 0

var high_score_save_data : SaveData

func _ready() -> void:
	# Creating and storing the SaveData file
	high_score_save_data = SaveData.load_or_create()
	
	Events.raycast_position_update.connect(increment_current_score)
	Events.scene_reset.connect(reset_score)

func increment_current_score(score: int) -> void:
	current_score += score
	print_debug("The new score is: ", current_score)

func reset_score() -> void:
	# Saving the highscore
	if high_score_save_data.high_score < current_score:
		Events.set_highscore.emit(current_score)
		high_score_save_data.high_score = current_score
		high_score_save_data.save()
	
	# Resetting the score
	current_score = 0
	print_debug("The score has been reset!")
