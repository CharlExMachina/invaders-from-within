class_name BulletCage
extends Spatial

export var movement_speed := 30.0

var target_pos: Vector3 setget target_pos_set
var dir := Vector3.ZERO

func _process(delta: float) -> void:
	global_translation += dir * movement_speed * delta


func target_pos_set(value: Vector3) -> void:
	look_at(value, Vector3.UP)
	target_pos = value
	dir = (target_pos - global_translation).normalized()
