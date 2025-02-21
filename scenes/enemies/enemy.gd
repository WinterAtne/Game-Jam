class_name Enemy
extends CharacterBody2D

var type : EnemyType = null

var min_distance : float = 200
var neighbors : Array[BoidArea] = []

var target : Node2D
var travel_direction : Vector2 = Vector2.ZERO

func _ready() -> void:
	target = Player.instance

func _physics_process(delta: float) -> void:
	var coherence : Vector2
	for neighbor in neighbors:
		var direction = global_position.direction_to(neighbor.global_position)
		var distance = global_position.distance_to(neighbor.global_position)
		if distance < min_distance:
			coherence -= direction * distance
		else:
			coherence += direction / distance
	
	var target_direction : Vector2 = global_position.direction_to(target.global_position)
	
	travel_direction = travel_direction.move_toward(
		((target_direction * (1 - type.coherence_ratio))
		+ (coherence * type.coherence_ratio)).normalized(),
		delta * type.change_direction)
	
	velocity = velocity.move_toward(
		travel_direction * type.speed,
		type.acceloration * delta * Engine.physics_ticks_per_second)
	
	move_and_slide()

func die() -> void:
	queue_free()

func _on_boid_area_area_entered(area: Area2D) -> void:
	if area is BoidArea:
		neighbors.append(area)

func _on_boid_area_area_exited(area: Area2D) -> void:
	if area is BoidArea and neighbors.has(area):
		neighbors.erase(area)
