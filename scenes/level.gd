class_name Level
extends Node2D

signal game_over

static var instance : Level = null

func _init() -> void:
	if instance == null:
		instance = self
	else:
		self.queue_free()

func end_game() -> void:
	game_over.emit()
