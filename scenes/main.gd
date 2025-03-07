class_name Main
extends Node2D

static var instance : Main = null

@export var level_template : PackedScene
var level : Level

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
	%MenuCamera.enabled = true

func load_options() -> void:
	disable_ui()
	disable_gameplay()
	%Options.visible = true
	%MenuCamera.enabled = true

func load_credits() -> void:
	disable_ui()
	disable_gameplay()
	%Credits.visible = true
	%MenuCamera.enabled = true

func load_death_screen() -> void:
	if Player.instance != null:
		%DeathScreen.set_death_count(Player.instance.jam_count)
	disable_ui()
	disable_gameplay()
	%DeathScreen.visible = true
	%MenuCamera.enabled = true

func load_level() -> void:
	disable_ui()
	disable_gameplay()
	level = level_template.instantiate()
	add_child.call_deferred(level)
	if level.has_signal("game_over"):
		level.game_over.connect(load_death_screen)

func disable_ui() -> void:
	%MainMenu.visible = false
	%Credits.visible = false
	%DeathScreen.visible = false
	%Options.visible = false
	%MenuCamera.enabled = false

func disable_gameplay() -> void:
	if level != null:
		level.queue_free()
		level = null
