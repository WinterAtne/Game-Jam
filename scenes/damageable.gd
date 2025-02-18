class_name Damageable
extends Area2D

signal took_damage(attacker : Damager)

func _init() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(attacker: Area2D) -> void:
	if attacker is Damager:
		took_damage.emit(attacker)
