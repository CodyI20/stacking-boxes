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
	high_score_logic()
	
	# Resetting the score
	current_score = 0
	print_debug("The score has been reset!")

func high_score_logic() -> void:
	var high_scores = [
		high_score_save_data.high_score,
		high_score_save_data.high_score_2,
		high_score_save_data.high_score_3,
		high_score_save_data.high_score_4,
		high_score_save_data.high_score_5
	]
	
	var score_updated = false
	
	for i in range(high_scores.size()):
		if current_score > high_scores[i]:
			high_scores.insert(i, current_score)
			high_scores.pop_back()
			score_updated = true
			break
	if score_updated:
		high_score_save_data.high_score_5 = high_scores[4]
		high_score_save_data.high_score_4 = high_scores[3]
		high_score_save_data.high_score_3 = high_scores[2]
		high_score_save_data.high_score_2 = high_scores[1]
		high_score_save_data.high_score = high_scores[0]
		high_score_save_data.save()
