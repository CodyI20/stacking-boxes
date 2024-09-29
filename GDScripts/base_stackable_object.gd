extends RigidBody2D

@export var move_speed := 10.0

func _ready() -> void:
	freeze = true
	
func pre_release_process() -> void:
	if freeze == false:
		return
	var direction := Input.get_axis("Left","Right")
	global_position.x += move_speed * direction
	
	# Clamp the global_position to the viewport boundaries
	global_position.x = clamp(global_position.x, 0, get_viewport_rect().size.x)
	
func try_release_process() -> void:
	if Input.is_action_just_pressed("Space"):
		Events.object_released.emit()
		freeze = false
		
		# Reset the velocity to make sure the object doesn't fly off due to any previous movement while frozen
		linear_velocity = Vector2.ZERO
	
func _process(delta: float) -> void:
	try_release_process()

func _physics_process(delta: float) -> void:
	pre_release_process()
