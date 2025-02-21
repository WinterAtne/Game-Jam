extends Enemy

func get_direction_to_target() -> Vector2:
	var target_pos := Player.instance.global_position
	return global_position.direction_to(target_pos)
