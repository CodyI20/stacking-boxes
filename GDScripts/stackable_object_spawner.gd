extends Node2D

var stackableObjectsScenes := [preload("res://Scenes/Inherited/StackableObject/Base/base_stackable_object.tscn"), preload("res://Scenes/Inherited/StackableObject/square_stackable_object.tscn")
, preload("res://Scenes/Inherited/StackableObject/triangle_stackable_object.tscn")]
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Check if the spawner has objects inside of it to be able to spawn new ones
	if get_child_count() == 0:
		spawn_object()
	queue_redraw()

# This function gets a random number, then gets a random scene from the array and instantiates it
func spawn_object() -> void:
	# Get the random number
	var random_object_number := rng.randf_range(0, stackableObjectsScenes.size())
	
	# Save the instance of the scene in a variable so we can modify certain properties, such as the position in this case
	var scene_instance = stackableObjectsScenes[random_object_number].instantiate()
	
	# Set the position of the scene instance to the parameter
	scene_instance.global_position = to_local(global_position)
	
	# Add it as child to the Node this script is attached to
	add_child(scene_instance)

func _draw() -> void:
	draw_circle(to_local(global_position), 2.0, Color.RED)
