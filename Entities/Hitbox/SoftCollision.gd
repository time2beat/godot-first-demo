extends Area2D

func is_colliding() -> bool:
	var areas = get_overlapping_areas()
	return areas.size() > 0

func gen_push_vector() -> Vector2:
	if is_colliding():
		var areas = get_overlapping_areas()
		var push_vector = areas[0].global_position.direction_to(global_position)
		return push_vector.normalized()
	else:
		return Vector2.ZERO
