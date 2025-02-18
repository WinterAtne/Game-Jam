class_name TestDummy
extends Node2D

func die() -> void:
	queue_free()

func _on_damageable_died() -> void:
	die()
