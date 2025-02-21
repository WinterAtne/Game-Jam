extends Enemy

var lead_by : float = -0.5

func get_direction_to_target() -> Vector2:
	var target_pos := Player.instance.velocity * lead_by + Player.instance.global_position
	return global_position.direction_to(target_pos)
