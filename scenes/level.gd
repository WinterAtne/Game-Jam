class_name Level
extends Node2D

static var instance : Level = null

func _ready() -> void:
	if instance == null:
		instance = self
	else:
		self.queue_free()
