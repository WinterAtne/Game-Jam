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

func load_credits() -> void:
	disable_ui()
	disable_gameplay()
	%Credits.visible = true

func load_death_screen() -> void:
	disable_ui()
	disable_gameplay()
	%DeathScreen.visible = true

func load_level() -> void:
	disable_ui()
	if level.get_parent() == null:
		add_child.call_deferred(level)

func disable_ui() -> void:
	%MainMenu.visible = false
	%Credits.visible = false
	%DeathScreen.visible = false

func disable_gameplay() -> void:
	if level.get_parent() == self:
		remove_child.call_deferred(level)
