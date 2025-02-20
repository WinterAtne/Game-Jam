class_name Damageable
extends Area2D

signal took_damage(attacker : Damager, new_health : int, direction : Vector2)
signal died()

@export var max_health : int
@onready var current_health : int = max_health

func _init() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(attacker: Area2D) -> void:
	if attacker is Damager:
		current_health -= attacker.damage
		if current_health <= 0:
			died.emit()
		else:
			took_damage.emit(attacker, current_health, global_position.direction_to(attacker.global_position))
	
