extends RayCast2D

var has_collided: bool = false

func _ready() -> void:
	Events.object_frozen.connect(update_position)
	
func update_position(object: Node2D) -> void:
	if is_colliding():
		var collider = get_collider()
		if collider != object:
			return
		if collider.has_node("Icon"):
			var sprite = collider.get_node("Icon")
			var sprite_actual_Y_size = sprite.texture.get_size().y * sprite.scale.y
			global_position.y = collider.global_position.y - sprite_actual_Y_size/2 - 1
			print_debug("Position of Y is: ", global_position.y)
