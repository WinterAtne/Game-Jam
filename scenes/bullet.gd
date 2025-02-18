class_name Bullet
extends RigidBody2D

@export var mussle_velocity : float

func fire(dir : Vector2, pos : Vector2) -> void:
	position = pos
	apply_impulse(dir * mussle_velocity)
	pass


func die() -> void:
	self.queue_free()
