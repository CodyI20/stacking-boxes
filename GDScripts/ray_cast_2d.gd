extends RayCast2D

var has_collided: bool = false

func _ready() -> void:
	Events.object_frozen.connect(update_position)
	
func _process(delta: float) -> void:
	queue_redraw()
	
func update_position(object: Node2D) -> void:
	var highest_point = highest_sprite_point(object)
	
	if global_position.y > highest_point:
		Events.raycast_position_update.emit()
		global_position.y = highest_point
		
			
func highest_sprite_point(object: Object) -> float:
	var sprite : Sprite2D
	if object.has_node("Icon"):
			sprite = object.get_node("Icon")
	else:
		print_debug("There is no node named <<ICON>> in this object. Make sure to add one!")
		return 0
	var half_extents = sprite.texture.get_size() * sprite.scale/2
	var rotation = object.rotation
	
	var local_corners = [
		Vector2(-half_extents.x, -half_extents.y),
		Vector2(half_extents.x, -half_extents.y),
		Vector2(half_extents.x, half_extents.y),
		Vector2(-half_extents.x, half_extents.y)
	]
	
	var world_corners = []
	var highest_corner_y = INF
	for corner in local_corners:
		var rotated_corner = corner.rotated(rotation)
		var world_corner = object.global_position + rotated_corner
		if world_corner.y < highest_corner_y:
			highest_corner_y = world_corner.y
	
	return highest_corner_y

func _draw() -> void:
	draw_line(Vector2(global_position.x, 0), target_position, Color.GREEN)
