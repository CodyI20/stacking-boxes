extends Control



func _on_retry_button_pressed() -> void:
	GameManager.retry_level()


func _on_menu_button_pressed() -> void:
	GameManager.go_to_main_menu()


func _on_quit_button_pressed() -> void:
	GameManager.quit_game()
