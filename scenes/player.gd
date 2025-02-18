extends CharacterBody2D

signal gun_fied(direction : Vector2)

const SPEED = 300.0

func _physics_process(delta: float) -> void:
	# Movement Logic
	var direction_x := Input.get_axis("left", "right")
	var direction_y := Input.get_axis("up", "down") # Godot axises are upside down
	var target_velocity := Vector2(direction_x, direction_y) * SPEED
	
	velocity = velocity.move_toward(target_velocity, SPEED * delta * Engine.physics_ticks_per_second)
	
	move_and_slide()
	
	# Gun logic
	if (Input.is_action_just_pressed("shoot")):
		gun_fied.emit(position.direction_to(get_global_mouse_position()))
	

func _on_damageable_died() -> void:
	print("I died")
