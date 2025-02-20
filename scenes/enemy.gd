class_name Enemy
extends CharacterBody2D

const SPEED : int = 600

func _physics_process(delta: float) -> void:
	var target_direction : Vector2 = global_position.direction_to(Player.instance.global_position)
	
	velocity = velocity.move_toward(target_direction * SPEED, SPEED * delta * Engine.physics_ticks_per_second)
	
	move_and_slide()

func die() -> void:
	queue_free()

func _on_damageable_died() -> void:
	die()
