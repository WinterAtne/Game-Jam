class_name Enemy
extends CharacterBody2D

@export var speed : int = 600
@export var recovery_time : float = 1

var min_distance : float = 200
var boid_behavior : float = 0.50
var neighbors : Array[BoidArea] = []

var travel_direction : Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	travel_direction = travel_direction.move_toward(
		(get_direction_to_target() * (1 - boid_behavior) + get_coherence() * boid_behavior).normalized(),
		delta * recovery_time)
	
	velocity = velocity.move_toward(travel_direction * speed, speed * delta * Engine.physics_ticks_per_second)
	
	move_and_slide()


func get_direction_to_target() -> Vector2:
	return Vector2.ZERO

func get_coherence() -> Vector2:
	var coherence : Vector2
	for neighbor in neighbors:
		var direction = global_position.direction_to(neighbor.global_position)
		var distance = global_position.distance_to(neighbor.global_position)
		if distance < min_distance:
			coherence -= direction * distance
		else:
			coherence += direction / distance
	
	return coherence

func die() -> void:
	queue_free()

func _on_boid_area_area_entered(area: Area2D) -> void:
	if area is BoidArea:
		neighbors.append(area)

func _on_boid_area_area_exited(area: Area2D) -> void:
	if area is BoidArea and neighbors.has(area):
		neighbors.erase(area)
