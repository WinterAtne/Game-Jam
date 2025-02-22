class_name Level
extends Node2D

signal game_over

static var instance : Level = null

@export var enemy_template : PackedScene = null
@export var enemy_types : Array[EnemyType] = []
@export var enemy_spawn_dinstance : int = 2000

var spawned_enemies : Array[int] = []

func _init() -> void:
	if instance == null:
		instance = self
	else:
		self.queue_free()

func _ready() -> void:
	spawned_enemies.resize(enemy_types.size())
	spawned_enemies.fill(0)

func spawn_enemies() -> void:
	var type_index : int = randi_range(0, enemy_types.size() -1)
	var type : EnemyType = enemy_types[type_index]
	if (spawned_enemies[type_index] >= type.max_spawn_count):
		return
	spawned_enemies[type_index] += 1
	
	var spawned_enemy : Enemy = enemy_template.instantiate()
	spawned_enemy.type = type
	add_child(spawned_enemy)
	
	var direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	spawned_enemy.position = enemy_spawn_dinstance * direction + Player.instance.global_position
	
	spawned_enemy.died.connect(func(): spawned_enemies[type_index] -= 1)
	

func end_game() -> void:
	game_over.emit()
