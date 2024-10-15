extends Control

func _ready() -> void:
	Events.options_menu_toggle.connect(options_toggle)
	
func options_toggle(is_true: bool) -> void:
	visible = !is_true
	set_process(!is_true)
