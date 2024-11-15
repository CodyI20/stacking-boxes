extends Area2D

# The collision mask of this area2D is set to "Rigidbodies", therefore no additional check logic, such as " if collision_layer == ?? ", is required here
func _on_body_entered(body: Node2D) -> void:
	Events.game_over.emit()
	Utility.go_to_high_score_scene()
