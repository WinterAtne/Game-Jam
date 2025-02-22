class_name Enemy
extends CharacterBody2D

signal died()

var type : EnemyType = null

var min_distance : float = 32
var neighbors : Array[BoidArea] = []

var target : Node2D
var travel_direction : Vector2 = Vector2.ZERO

func _ready() -> void:
	target = Player.instance
	%Damageable.max_health = type.max_health
	%Damageable.current_health = %Damageable.max_health
	%Damager.knockback = type.knockback
	%Sprite2D.texture = type.sprite

func _physics_process(delta: float) -> void:
	var coherence : Vector2
	for neighbor in neighbors:
		var direction = global_position.direction_to(neighbor.global_position)
		var distance = global_position.distance_to(neighbor.global_position)
		if distance < min_distance:
			coherence -= direction * distance
		else:
			coherence += direction / distance
	
	var target_direction : Vector2 = (
		global_position.direction_to(target.global_position + (target.velocity * type.lead_by)))
	
	travel_direction = travel_direction.move_toward(
		((target_direction * (1 - type.coherence_ratio))
		+ (coherence * type.coherence_ratio)).normalized(),
		delta * type.change_direction)
	
	velocity = velocity.move_toward(
		travel_direction * type.speed,
		type.acceloration * delta * Engine.physics_ticks_per_second)
	
	move_and_slide()

func die() -> void:
	died.emit()
	queue_free()

func _on_boid_area_area_entered(area: Area2D) -> void:
	if area is BoidArea:
		neighbors.append(area)

func _on_boid_area_area_exited(area: Area2D) -> void:
	if area is BoidArea and neighbors.has(area):
		neighbors.erase(area)
