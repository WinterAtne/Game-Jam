class_name Level
extends Node2D

signal game_over

static var instance : Level = null

@export var enemy_template : PackedScene = null
@export var enemy_types : Array[EnemyType] = []
@export var enemy_spawn_dinstance : int = 2000

func _init() -> void:
	if instance == null:
		instance = self
	else:
		self.queue_free()

func spawn_enemies() -> void:
	var type : EnemyType = enemy_types.pick_random()
	var spawned_enemy : Enemy = enemy_template.instantiate()
	spawned_enemy.type = type
	add_child(spawned_enemy)
	
	var direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	spawned_enemy.position = enemy_spawn_dinstance * direction + Player.instance.global_position
	

func end_game() -> void:
	game_over.emit()
