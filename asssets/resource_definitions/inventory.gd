class_name Inventory
extends Node

const SIZE : int = 8
var items : Array[Item] = []

func _ready() -> void:
	items.resize(SIZE)

func is_full() -> bool:
	for i in items:
		if i == null:
			return false
	
	return true

func add(new_item : Item) -> bool:
	for i in range(items.size()):
		if items[i] == null:
			items[i] = new_item
			return true
	
	return false

func remove(to_remove : Item) -> bool:
	for i in range(items.size()):
		if items[i] == to_remove:
			items[i] = null
			return true
	
	return false
