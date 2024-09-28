extends RigidBody2D

@export var move_speed := 10.0

func _ready() -> void:
	freeze = true
	
func pre_release_process() -> void:
	if freeze == false:
		return
	var direction := Input.get_axis("Left","Right")
	global_position.x += move_speed * direction
	
func try_release_process() -> void:
	if Input.is_action_just_pressed("Space"):
		freeze = false
	
func _process(delta: float) -> void:
	try_release_process()

func _physics_process(delta: float) -> void:
	pre_release_process()
