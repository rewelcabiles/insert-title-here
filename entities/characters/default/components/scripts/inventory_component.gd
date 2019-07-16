extends Node

class_name InventoryComponent

export(int) var gold = 0
export(int) var slots = 10
var inventory = {}

signal update



func _ready():
	setup_inventory()

func setup_inventory():
	for i in range(slots):
		inventory[i] = null

func get_slot(slot_index):
	return inventory[slot_index]

func remove_slot(slot_index):
	inventory[slot_index] = null
	emit_signal("update", slot_index)

func add_to_slot(item: ItemObject, slot_index: int):
	inventory[slot_index] = item
	emit_signal("update", slot_index)

func get_first_empty_slot():
	for index in range(inventory.size()):
		if inventory[index] == null:
			return index
	return null

func add_to_first_empty_slot(item: ItemObject):
	var pos = get_first_empty_slot()
	if pos != null:
		add_to_slot(item, pos)

func drop():
	pass