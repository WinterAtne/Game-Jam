extends Node2D

@export var inventory : Inventory
@export var itm : Item

func _ready() -> void:
	inventory = $Inventory
	while !inventory.is_full():
		inventory.add(itm)
