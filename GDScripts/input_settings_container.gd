extends Control

var savedSettings : SaveSettings

const INPUT_BUTTON = preload("res://Scenes/input_button.tscn")
@onready var action_list: VBoxContainer = $VBoxContainer/ScrollContainer/ActionList


var is_remapping = false
var action_to_remap = null
var remapping_button = null

func _ready() -> void:
	savedSettings = SaveSettings.load_or_create()
	for i in savedSettings.action_keys_remapped:
		print_debug("The KEY: %s has the VALUE: %s" % [i, savedSettings.action_keys_remapped[i]])
	create_action_list(false)
	
func _unhandled_input(event: InputEvent) -> void:
	if is_remapping:
		if (event is InputEventKey or (event is InputEventMouseButton and event.pressed)):
			if event is InputEventMouseButton and event.double_click:
				event.double_click = false
			#InputMap.action_erase_event(action_to_remap, event)
			InputMap.action_erase_events(action_to_remap)
			InputMap.action_add_event(action_to_remap, event)
			_update_action_list(remapping_button, event)
			
			
			#region SAVE TO SETTINGS
			savedSettings.action_keys_remapped[action_to_remap] = event
			savedSettings.save()
			#endregion
			
			is_remapping = false
			action_to_remap = null
			remapping_button = null
			
			accept_event()
			
	
func create_action_list(default := false) -> void:
	InputMap.load_from_project_settings()
	if not default and savedSettings.action_keys_remapped.size() > 0:
		for element in savedSettings.action_keys_remapped:
			InputMap.action_erase_event(element, InputMap.action_get_events(element)[0])
			InputMap.action_add_event(element, savedSettings.action_keys_remapped[element])
			
	for item in action_list.get_children():
		item.queue_free()
		
	for action in Utility.input_actions:
		var button = INPUT_BUTTON.instantiate()
		var action_label = button.find_child("ActionLabel")
		var input_label = button.find_child("InputLabel")
		
		action_label.text = Utility.input_actions[action]
		
		var events = InputMap.action_get_events(action)
		if events.size() > 0:
			input_label.text = events[0].as_text().trim_suffix(" (Physical)")
			if input_label.text == "Right" or input_label.text == "Left" or input_label.text == "Up" or input_label.text == "Down":
				input_label.text += " Arrow Key"
		else:
			input_label.text = ""
			
		action_list.add_child(button)
		
		#region SAVE SETTINGS
		savedSettings.action_keys_remapped.get_or_add(action)
		savedSettings.action_keys_remapped[action] = events[0]
		savedSettings.save()
		#endregion
		
		button.pressed.connect(_on_input_button_pressed.bind(button,action))
		
func _update_action_list(button, event) -> void:
	var action_label = button.find_child("ActionLabel")
	var input_label = button.find_child("InputLabel")
	input_label.text = event.as_text().trim_suffix(" (Physical)")
	if input_label.text == "Right" or input_label.text == "Left" or input_label.text == "Up" or input_label.text == "Down":
		input_label.text += " Arrow Key"

func _on_input_button_pressed(button, action):
	if is_remapping:
		return
	is_remapping = true
	action_to_remap = action
	remapping_button = button
	var button_input_label_name = "InputLabel"
	var button_input_label = button.find_child(button_input_label_name)
	if button_input_label == null:
		printerr("Could not find a child with the name %s for the object %s" % button_input_label_name, self)
	button_input_label.text = "Press key to bind..."

func _on_reset_button_pressed() -> void:
	create_action_list(true)
