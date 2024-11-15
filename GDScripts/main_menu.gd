extends Control


func _on_play_button_pressed() -> void:
	Utility.go_to_game_scene()

func _on_options_button_pressed() -> void:
	Utility.toggle_options_menu(true)

func _on_quit_button_pressed() -> void:
	Utility.quit_game()

	
