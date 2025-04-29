extends CharacterBody3D

@export var max_speed := 5.0
@export var acceleration := 8.0  # How quickly you speed up when holding W
@export var deceleration := 3.0  # How slowly you come to a stop after releasing W

var current_velocity := Vector3.ZERO  # Tracks our actual movement velocity

func _physics_process(delta):
	var target_velocity := Vector3.ZERO
	
	# Movement input
	if Input.is_action_pressed("forward"):
		target_velocity += -transform.basis.z * max_speed
	if Input.is_action_pressed("reverse"):
		target_velocity += transform.basis.z * max_speed
		
	# Flying input
	if Input.is_action_pressed("fly"):
		target_velocity += transform.basis.y * max_speed
	
	# Rotation
	if Input.is_action_pressed("left"):  
		global_rotation.y += 0.05
	if Input.is_action_pressed("right"):  
		global_rotation.y -= 0.05
	
	# Gravity when not flying and above ground
	if global_position.y > 1 && !Input.is_action_pressed("fly"):
		target_velocity -= transform.basis.y * max_speed
	
	# Smooth velocity transition
	if target_velocity != Vector3.ZERO:
		# Accelerate toward target velocity
		current_velocity = current_velocity.lerp(target_velocity, acceleration * delta)
	else:
		# Decelerate to zero
		current_velocity = current_velocity.move_toward(Vector3.ZERO, deceleration * delta)
	
	# Apply movement
	velocity = current_velocity
	move_and_slide()
