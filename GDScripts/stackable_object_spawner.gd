extends Node2D

var stackableObjectsScenes := [preload("res://Scenes/Inherited/StackableObject/Base/base_stackable_object.tscn"), preload("res://Scenes/Inherited/StackableObject/square_stackable_object.tscn")
, preload("res://Scenes/Inherited/StackableObject/triangle_stackable_object.tscn")]
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Space"):
		spawn_object()

func spawn_object() -> void:
	var random_object_number := rng.randf_range(0, stackableObjectsScenes.size())
	add_child(stackableObjectsScenes[random_object_number])
