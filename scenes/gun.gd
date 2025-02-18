extends Node2D

@export var bullet : PackedScene

func shoot(direction : Vector2) -> void:
	var bullet_instance : Bullet = bullet.instantiate()
	Level.instance.add_child(bullet_instance)
	bullet_instance.fire(direction, global_position)

func die() -> void:
	self.queue_free()
