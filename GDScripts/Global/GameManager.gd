extends Node

# GAME SETTINGS
var window_mode := DisplayServer.WINDOW_MODE_WINDOWED
var resolution := Vector2i(1280,720)

func _process(delta: float) -> void:
	enable_options_menu_key_check()
		
# OVERLAY TOGGLE
func enable_options_menu() -> void:
	Events.options_menu_toggle.emit(true)
	
func enable_options_menu_key_check() -> void:
	if Input.is_action_just_pressed("Esc"):
		enable_options_menu()
		

# SCENE SWAPPING LOGIC
func go_to_main_menu() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/main_menu.tscn")

func retry_level() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/game.tscn")

func go_to_high_score_scene() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/highscore.tscn")

func go_to_game_scene() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/game.tscn")

func quit_game() -> void:
	get_tree().quit()
