extends Area2D

# The collision mask of this area2D is set to "Rigidbodies", therefore no additional check logic, such as " if collision_layer == ?? ", is required here
func _on_body_entered(body: Node2D) -> void:
	Events.scene_reset.emit()
	get_tree().call_deferred("reload_current_scene")
