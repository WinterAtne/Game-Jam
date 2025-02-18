extends CharacterBody2D


const SPEED = 300.0


func _physics_process(delta: float) -> void:
	var direction_x := Input.get_axis("left", "right")
	var direction_y := Input.get_axis("up", "down") # Godot axises are upside down
	var target_velocity := Vector2(direction_x, direction_y) * SPEED
	
	velocity = velocity.move_toward(target_velocity, SPEED * delta * Engine.physics_ticks_per_second)

	move_and_slide()
