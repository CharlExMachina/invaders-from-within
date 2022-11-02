extends KinematicBody

export var movement_speed := 30.0
export var movement_limits_unsigned := Vector2(13.29, 7.175)

var crosshair: Sprite3D
var tween: Tween

var _bullet_cage = preload("res://src/entities/ammo/bullet_cage/BulletCage.tscn")

var _velocity := Vector3.ZERO
var _target_rotation := Vector3.ZERO

func _process(delta: float) -> void:
	_handle_movement()
	_handle_shooting()

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

	var target_rotation_x = 65.0 * y_axis_input
	var target_rotation_y = 65.0 * x_axis_input
	_target_rotation = Vector3(target_rotation_x, -target_rotation_y, 0.0)
	tween.interpolate_property(self, "rotation_degrees", rotation_degrees, _target_rotation, 0.4)
	tween.start()

	_velocity = Vector3(x_axis_input, y_axis_input, 5) * movement_speed * get_process_delta_time()

func _handle_shooting() -> void:
	if Input.is_action_just_pressed("shoot"):
		var bullet_cage_instance: BulletCage = _bullet_cage.instance()
		get_tree().root.add_child(bullet_cage_instance)
		bullet_cage_instance.global_rotation = get_parent().global_rotation
		bullet_cage_instance.global_translation = $SpringArm/CrosshairGuide/InnerCrosshairGuide.global_translation
		var crosshair_translation = crosshair.global_translation
		bullet_cage_instance.target_pos = Vector3(crosshair_translation.x,
				crosshair_translation.y, crosshair_translation.z)
