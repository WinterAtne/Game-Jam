class_name Damager
extends Area2D

signal did_damage()

@export var damage : int = 1
@export var knockback : float = 200

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(area : Area2D) -> void:
	if area is Damageable:
		did_damage.emit()
