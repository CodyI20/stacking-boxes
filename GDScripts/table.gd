extends StaticBody2D

@onready var area_2d: Area2D = $Area2D

# Won't check for the layer the body is in since the Area2D has a mask for that layer only already
func _on_area_2d_body_entered(body: Node2D) -> void:
	Events.object_hit_safe_ground.emit(body)


func _on_area_2d_body_exited(body: Node2D) -> void:
	Events.object_left_safe_ground_early.emit(body)
