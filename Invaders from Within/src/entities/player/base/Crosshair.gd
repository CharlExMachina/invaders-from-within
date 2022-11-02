extends SpringArm

export var movement_speed := 30.0
export var movement_limits_unsigned := Vector2(13.29, 7.175)

var _velocity := Vector3.ZERO

func _process(delta: float) -> void:
	_handle_movement()
	_handle_reset_crosshair()

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

func _handle_reset_crosshair() -> void:
	if Input.is_action_just_pressed("reset_crosshair_position"):
		var tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_EXPO)
		tween.tween_property(self, "rotation_degrees", Vector3.ZERO, 0.2)
