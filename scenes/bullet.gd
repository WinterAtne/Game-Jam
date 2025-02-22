class_name Bullet
extends Node2D

@export var mussle_velocity : float
var direction : Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	position += direction * mussle_velocity * delta

func fire(dir : Vector2, pos : Vector2) -> void:
	position = pos
	direction = dir

func die() -> void:
	self.queue_free()

func _on_damager_did_damage() -> void:
	die()
