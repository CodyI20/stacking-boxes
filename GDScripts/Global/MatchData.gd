extends Node

var current_score := 0

func increment_current_score(_score_to_add: int) -> void:
	current_score += _score_to_add
	print_debug("The new score is: ", current_score)
