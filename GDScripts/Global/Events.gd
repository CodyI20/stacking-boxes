extends Node

# STACKABLE OBJECT
signal object_released(object: Node2D)
signal object_hit_safe_ground(object: Node2D)
signal object_left_safe_ground_early(object: Node2D)
signal object_frozen(object: Node2D)

# RAYCAST
signal raycast_position_update

# SCENE
signal scene_reset
