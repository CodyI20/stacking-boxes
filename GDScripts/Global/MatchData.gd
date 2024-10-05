extends Node

var current_score := 0

func _ready() -> void:
	Events.object_frozen.connect(increment_current_score)
	

func increment_current_score(object: Node2D) -> void:
	current_score += 1
	print_debug("The new score is: ", current_score)
