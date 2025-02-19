class_name Player
extends CharacterBody2D

signal gun_fied(direction : Vector2)

const SPEED = 300.0
const knockback_resistance = 20

static var instance : Player = null

var knockback : Vector2 = Vector2.ZERO

func _ready() -> void:
	if instance == null:
		instance = self
	else:
		self.queue_free()

func _physics_process(delta: float) -> void:
	
	# Movement Logic
	var direction_x := Input.get_axis("left", "right")
	var direction_y := Input.get_axis("up", "down") # Godot axises are upside down
	var target_velocity := Vector2(direction_x, direction_y) * SPEED
	
	if knockback != Vector2.ZERO:
		target_velocity = knockback
		knockback = knockback.move_toward(Vector2.ZERO, knockback_resistance * delta * Engine.physics_ticks_per_second)
	
	velocity = velocity.move_toward(target_velocity, SPEED * delta * Engine.physics_ticks_per_second)
	
	move_and_slide()
	
	# Gun logic
	if (Input.is_action_just_pressed("shoot")):
		gun_fied.emit(position.direction_to(get_global_mouse_position()))
	

func _on_damageable_died() -> void:
	Main.instance.load_death_screen()

func _on_damageable_took_damage(attacker: Damager, new_health: int, direction: Vector2) -> void:
	knockback = attacker.knockback * -direction
	velocity += knockback
