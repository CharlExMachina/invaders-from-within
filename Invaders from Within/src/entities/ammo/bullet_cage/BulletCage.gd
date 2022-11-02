extends Spatial

export var movement_speed := 30.0

func _process(delta: float) -> void:
	translation.z -= movement_speed * delta
