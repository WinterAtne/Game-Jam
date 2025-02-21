class_name Level
extends Node2D

signal game_over

static var instance : Level = null

@export var enemy_types : Array[PackedScene] = []
@export var enemy_spawn_dinstance : int = 2000

func _init() -> void:
	if instance == null:
		instance = self
	else:
		self.queue_free()

func spawn_enemies() -> void:
	var template : PackedScene = enemy_types.pick_random()
	var spawned_enemy = template.instantiate()
	add_child(spawned_enemy)
	
	var direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	spawned_enemy.position = enemy_spawn_dinstance * direction + Player.instance.global_position
	

func end_game() -> void:
	game_over.emit()
