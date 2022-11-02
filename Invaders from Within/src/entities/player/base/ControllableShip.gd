extends KinematicBody

export var movement_speed := 30.0
export var movement_limits_unsigned := Vector2(13.29, 7.175)

var bullet_cage = preload("res://src/entities/ammo/bullet_cage/BulletCage.tscn")

var _velocity := Vector3.ZERO

func _process(delta: float) -> void:
	_handle_movement()

	if Input.is_action_just_pressed("shoot"):
		var bullet_cage_instance: BulletCage = bullet_cage.instance()
		get_tree().root.add_child(bullet_cage_instance)
		bullet_cage_instance.global_rotation = get_parent().global_rotation
		bullet_cage_instance.global_translation = global_translation
		var crosshair_translation = get_parent().get_node("Crosshair").global_translation
#		var origin_translation = get_parent().get_node("BulletOrigin").global_translation
#		var bullet_direction = crosshair_translation - origin_translation
#		print(bullet_direction)
		bullet_cage_instance.direction = Vector3(crosshair_translation.x, crosshair_translation.y, crosshair_translation.z - 3.0)

func _physics_process(delta: float) -> void:
	translation += _velocity
	var clamped_x_movement = clamp(translation.x, -movement_limits_unsigned.x, movement_limits_unsigned.x)
	var clamped_y_movement = clamp(translation.y, -movement_limits_unsigned.y, movement_limits_unsigned.y)
	translation = Vector3(clamped_x_movement, clamped_y_movement, 0.0)

func _handle_movement() -> void:
	var x_axis_input =\
		 	Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_axis_input =\
			 Input.get_action_strength("move_up") - Input.get_action_strength("move_down")

	_velocity = Vector3(x_axis_input, y_axis_input, 0.0) * movement_speed * get_process_delta_time()
