class_name Main
extends Node2D

static var instance : Main = null

@export var level : Level

func _ready() -> void:
	if instance == null:
		instance = self
	else:
		self.queue_free()
	
	load_main_menu()

func load_main_menu() -> void:
	disable_ui()
	disable_gameplay()
	%MainMenu.visible = true

func load_level() -> void:
	disable_ui()
	add_child(level)

func disable_ui() -> void:
	%MainMenu.visible = false

func disable_gameplay() -> void:
	remove_child(level)
