extends Node

# STACKABLE OBJECT
signal object_released(object: Node2D)
signal object_hit_safe_ground(object: Node2D)
signal object_left_safe_ground_early(object: Node2D)
signal object_frozen(object: Node2D)

# RAYCAST
signal raycast_position_update(score_increment: int) # Gets called from ray_cast_2d.gd

# SCENE
signal options_menu_toggle(is_on: bool)
signal game_over()

# DATA
signal set_highscore(score: int)
