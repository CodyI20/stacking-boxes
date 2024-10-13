extends Node



# SCENE SWAPPING LOGIC
func go_to_main_menu() -> void:
	get_tree().call_deferred("reload_current_scene")
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/game.tscn")

func retry_level() -> void:
	get_tree().call_deferred("reload_current_scene")
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/game.tscn")

func go_to_high_score_scene() -> void:
	get_tree().call_deferred("reload_current_scene")
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/highscore.tscn")

func quit_game() -> void:
	get_tree().quit()
