class_name Player
extends CharacterBody2D

signal gun_fied(direction : Vector2)
signal died

const SPEED = 320.0
const UNLOCK_MOVEMENT_UNDER_KNOCKBACK = 100
const knockback_resistance = 60
const heal_after : float = 4.0
const heal_again : float = 0.5
const shooting_time : float = 30
const jam_time : float = 10

static var instance : Player = null

var knockback : Vector2 = Vector2.ZERO
var is_jammed : bool = false

var normal_color : Color = Color.TRANSPARENT
@onready var return_color : Color = normal_color
var damage_color : Color = Color(0.8, 0.0, 0.1, 0.2)
var jam_color : Color = Color(0.6, 0.0, 0.3, 0.2)
var color_transition_weight : float = 0.1

func _ready() -> void:
	if instance == null:
		instance = self
	else:
		self.queue_free()
	
	%JamTimer.start(shooting_time)

func _physics_process(delta: float) -> void:
	
	# Movement Logic
	var direction_x := Input.get_axis("left", "right")
	var direction_y := Input.get_axis("up", "down") # Godot axises are upside down
	var target_velocity := Vector2(direction_x, direction_y).normalized() * SPEED
	
	if knockback != Vector2.ZERO:
		# Don't allow the player to move towards the enemy
		# Unless they aren't being knocked back too much
		if knockback.dot(target_velocity) > 0 || \
		knockback.length() > UNLOCK_MOVEMENT_UNDER_KNOCKBACK:
			target_velocity += knockback
		else:
			target_velocity = knockback
		
		knockback = knockback.move_toward(Vector2.ZERO, knockback_resistance * delta * Engine.physics_ticks_per_second)
	else:
		%TintLayer.change_color(return_color, color_transition_weight)
	
	velocity = velocity.move_toward(target_velocity, SPEED * delta * Engine.physics_ticks_per_second)
	
	move_and_slide()
	
	# Gun logic
	if (!is_jammed and Input.is_action_just_pressed("shoot")):
		gun_fied.emit(position.direction_to(get_global_mouse_position()))
	

func _on_damageable_died() -> void:
	died.emit()

func _on_damageable_took_damage(attacker: Damager, new_health: int, direction: Vector2) -> void:
	knockback = attacker.knockback * -direction
	velocity += knockback / 4
	%TintLayer.change_color(damage_color, color_transition_weight)
	%PlayerStatus.set_health(new_health)
	%HealTimer.stop()
	%HealTimer.start(heal_after)


func _on_heal_timer_timeout() -> void:
	var new_health = %Damageable.heal(1)
	%HealTimer.start(heal_again)
	%PlayerStatus.set_health(new_health)


func _on_jam_timer_timeout() -> void:
	if is_jammed:
		is_jammed = false
		%JamTimer.start(shooting_time)
		%TintLayer.change_color(normal_color, color_transition_weight)
		return_color = normal_color
	else:
		is_jammed = true
		%JamTimer.start(jam_time)
		%TintLayer.change_color(jam_color, color_transition_weight)
		return_color = jam_color
