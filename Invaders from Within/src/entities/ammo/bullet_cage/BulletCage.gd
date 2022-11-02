class_name BulletCage
extends Spatial

export var movement_speed := 30.0

var direction := Vector3.ZERO setget movement_speed_set
var target_pos: Vector3
var motion = Vector3.ZERO

func _process(delta: float) -> void:
	var targetVector = (target_pos).normalized()
	motion += targetVector
	motion = motion * -movement_speed * delta
	global_translate(motion)

func movement_speed_set(value: Vector3) -> void:
	look_at(value, Vector3.UP)
	target_pos = target_pos - global_translation
	direction = value
