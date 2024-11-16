extends Control

const INPUT_BUTTON = preload("res://Scenes/input_button.tscn")
@onready var action_list: VBoxContainer = $VBoxContainer/ScrollContainer/ActionList


var is_remapping = false
var action_to_remap = null
var remapping_button = null

var input_actions = {
	"Right" : "Right",
	"Left" : "Left",
	"Space" : "Release Object"
}

func _ready() -> void:
	create_action_list()
	
func _unhandled_input(event: InputEvent) -> void:
	if is_remapping:
		if (event is InputEventKey or (event is InputEventMouseButton and event.pressed)):
			if event is InputEventMouseButton and event.double_click:
				event.double_click = false
			#InputMap.action_erase_event(action_to_remap, event)
			InputMap.action_erase_events(action_to_remap)
			InputMap.action_add_event(action_to_remap, event)
			_update_action_list(remapping_button, event)
			
			is_remapping = false
			action_to_remap = null
			remapping_button = null
			
			accept_event()
			
	
func create_action_list() -> void:
	InputMap.load_from_project_settings()
	for item in action_list.get_children():
		item.queue_free()
		
	for action in input_actions:
		var button = INPUT_BUTTON.instantiate()
		var action_label = button.find_child("ActionLabel")
		var input_label = button.find_child("InputLabel")
		
		action_label.text = input_actions[action]
		
		var events = InputMap.action_get_events(action)
		if events.size() > 0:
			input_label.text = events[0].as_text().trim_suffix(" (Physical)")
			if input_label.text == "Right" or input_label.text == "Left" or input_label.text == "Up" or input_label.text == "Down":
				input_label.text += " Arrow Key"
		else:
			input_label.text = ""
			
		action_list.add_child(button)
		button.pressed.connect(_on_input_button_pressed.bind(button,action))
		
func _update_action_list(button, event) -> void:
	button.find_child("InputLabel").text = event.as_text().trim_suffix(" (Physical)")

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
	create_action_list()
