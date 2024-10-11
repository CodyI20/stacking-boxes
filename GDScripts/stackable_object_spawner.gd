extends Node2D

@onready var spawned_objects_container: Node2D = $"../../SpawnedObjectsContainer"
var stackableObjectsScenes := [preload("res://Scenes/Inherited/StackableObject/Base/base_stackable_object.tscn"), preload("res://Scenes/Inherited/StackableObject/square_stackable_object.tscn")
, preload("res://Scenes/Inherited/StackableObject/triangle_stackable_object.tscn")]
var rng = RandomNumberGenerator.new()

var can_spawn := true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.object_frozen.connect(on_object_frozen)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Check if the spawner has objects inside of it to be able to spawn new ones
	if can_spawn == true:
		spawn_object()
	queue_redraw()

# This function gets a random number, then gets a random scene from the array and instantiates it
func spawn_object() -> void:
	# Toggle the spawning off
	can_spawn = false
	
	# Get the random number
	var random_object_number := rng.randf_range(0, stackableObjectsScenes.size())
	
	# Save the instance of the scene in a variable so we can modify certain properties, such as the position in this case
	var scene_instance = stackableObjectsScenes[random_object_number].instantiate()
	
	# Set the position of the scene instance to the parameter
	scene_instance.global_position = global_position
	
	# Add it as child to the Node this script is attached to
	spawned_objects_container.add_child(scene_instance)

func on_object_frozen(object: Node2D) -> void:
	# Allow spawn
	can_spawn = true

func _draw() -> void:
	# Debug to see where the spawn point of the object scenes will be
	draw_circle(to_local(global_position), 2.0, Color.RED)
