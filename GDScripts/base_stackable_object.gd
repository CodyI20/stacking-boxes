extends RigidBody2D

@export var move_speed := 10.0
@onready var area_2d: Area2D = $Area2D

var object_released := false
var object_entered_safe_area := false

var static_turn_time := 0.3
var timer := 0.0

func _ready() -> void:
	freeze = true
	Events.object_hit_safe_ground.connect(on_object_hit_safe_ground_deferred)
	Events.object_released.connect(on_object_released)

#region RELEASE LOGIC
func pre_release_process() -> void:
	if object_released == true:
		return
	var direction := Input.get_axis("Left","Right")
	global_position.x += move_speed * direction
	
	# Clamp the global_position to the viewport boundaries
	global_position.x = clamp(global_position.x, 0, get_viewport_rect().size.x)
	
func try_release_process() -> void:
	if object_released == true:
		return
	if Input.is_action_just_pressed("Space"):
		Events.object_released.emit(self)
		freeze = false
		
		# Reset the velocity to make sure the object doesn't fly off due to any previous movement while frozen
		linear_velocity = Vector2.ZERO

func on_object_released(object: Node2D) -> void:
	if object != self:
		return
	object_released = true
#endregion
#region SAFE GROUND CHECK LOGIC
func on_object_hit_safe_ground_deferred(object: Node2D) -> void:
	call_deferred("object_hit_safe_ground", object)

func object_hit_safe_ground(object: Node2D) -> void:
	if object != self:
		return
	object_entered_safe_area = true
	print_debug("ENTERED SAFE AREA")

#endregion
#region TURN STATIC LOGIC
func make_static() -> void:
	Events.object_frozen.emit(self)
	freeze = true
	sleeping = true
	lock_rotation = true
	set_process(false)
	#print_debug("KILLING PROCESS...")

func freeze_object_process(delta: float) -> void:
	if object_entered_safe_area == true:
		#print_debug("SAFE AREA TRUE ... PROCEED TO FREEZING LOGIC")
		if linear_velocity.length() <= 0.001 and angular_velocity <= 0.001:
			#print_debug("SPEED VERY LOW: ", linear_velocity.length(), "; ", angular_velocity, " ! FREEZING...")
			make_static()
#endregion

# Won't check for the layer the body is in since the Area2D has a mask for that layer only already
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == self:
		return
	Events.object_hit_safe_ground.emit(body)

	
func _process(delta: float) -> void:
	try_release_process()
	freeze_object_process(delta)


func _physics_process(delta: float) -> void:
	pre_release_process()
