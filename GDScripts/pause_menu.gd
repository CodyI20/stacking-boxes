extends Control

@onready var animation_player: AnimationPlayer = $Pause/AnimationPlayer
@onready var pause_container: Control = $Pause

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.toggle_game_state.connect(on_game_state_change)
	Events.options_menu_toggle.connect(toggle_pause_container)
	animation_player.play("RESET")
	visible = false
	
func on_game_state_change(is_paused : bool) -> void:
	if is_paused:
		visible = true
		animation_player.play("Blur")
	else:
		visible = false
		animation_player.play_backwards("Blur")

func toggle_pause_container(turn_on: bool) -> void:
	pause_container.visible = !turn_on
	pause_container.set_process(!turn_on)


func _on_resume_button_pressed() -> void:
	Utility.pause_game(false)


func _on_restart_button_pressed() -> void:
	Utility.reload_scene()


func _on_options_button_pressed() -> void:
	Utility.toggle_options_menu(true)


func _on_menu_button_pressed() -> void:
	Utility.go_to_main_menu()


func _on_quit_button_pressed() -> void:
	Utility.quit_game()
