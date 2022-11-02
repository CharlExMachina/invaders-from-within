extends PathFollow

export var rail_movement_speed := 10.0

func _ready() -> void:
	assert(_validate_path(), "Player scene must be the child of a Path node")

func _process(delta: float) -> void:
	_follow_path()

func _validate_path() -> bool:
	var parent = get_parent()
	return parent is Path

func _follow_path() -> void:
	offset += rail_movement_speed * get_process_delta_time()

