extends Node

var current_score := 0

func _ready() -> void:
	Events.raycast_position_update.connect(increment_current_score)
	Events.scene_reset.connect(reset_score)

func increment_current_score(score: int) -> void:
	current_score += score
	print_debug("The new score is: ", current_score)

func reset_score() -> void:
	current_score = 0
	print_debug("The score has been reset!")
