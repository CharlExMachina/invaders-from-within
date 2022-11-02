extends SpringArm

export var movement_speed := 30.0
export var movement_limits_unsigned := Vector2(13.29, 7.175)

var _velocity := Vector3.ZERO

func _process(delta: float) -> void:
	_handle_movement()

#func _physics_process(delta: float) -> void:
##	rotation_degrees += _velocity
##
#	pass

func _handle_movement() -> void:
	var x_axis_input =\
		 	Input.get_action_strength("move_crosshair_right") - Input.get_action_strength("move_crosshair_left")
	var y_axis_input =\
			 Input.get_action_strength("move_crosshair_up") - Input.get_action_strength("move_crosshair_down")

	rotate(Vector3(0.0, -1.0, 0.0), x_axis_input * get_process_delta_time() * movement_speed)
	rotate(Vector3(1.0, 0.0, 0.0), y_axis_input * get_process_delta_time() * movement_speed)
	var clamped_x_movement = clamp(rotation_degrees.x, -movement_limits_unsigned.x, movement_limits_unsigned.x)
	var clamped_y_movement = clamp(rotation_degrees.y, -movement_limits_unsigned.y, movement_limits_unsigned.y)
	rotation_degrees = Vector3(clamped_x_movement, clamped_y_movement, 0.0)
#	_velocity = Vector3(x_axis_input, y_axis_input, 0.0) * movement_speed * get_process_delta_time()
