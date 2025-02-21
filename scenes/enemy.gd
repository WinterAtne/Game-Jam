class_name Enemy
extends CharacterBody2D

const SPEED : int = 600

var min_distance : float = 200
var boid_behavior : float = 0.50
var neighbors : Array[BoidArea] = []

var target_direction : Vector2 = Vector2.ZERO
func _physics_process(delta: float) -> void:
	
	var coherence : Vector2
	for neighbor in neighbors:
		var direction = global_position.direction_to(neighbor.global_position)
		var distance = global_position.distance_to(neighbor.global_position)
		if distance < min_distance:
			coherence -= direction * distance
		else:
			coherence += direction / distance
	
	target_direction = target_direction.move_toward(
		(global_position.direction_to(Player.instance.global_position) * (1 - boid_behavior) +
		coherence * boid_behavior).normalized(),
		delta)
	
	velocity = velocity.move_toward(target_direction * SPEED, SPEED * delta * Engine.physics_ticks_per_second)
	
	move_and_slide()

func die() -> void:
	queue_free()

func _on_damageable_died() -> void:
	die()

func _on_boid_area_area_entered(area: Area2D) -> void:
	if area is BoidArea:
		neighbors.append(area)

func _on_boid_area_area_exited(area: Area2D) -> void:
	if area is BoidArea and neighbors.has(area):
		neighbors.erase(area)
