extends Node

export(int) var gold = 0
export(int) var slots = 10
var inventory = {}

signal update



func _ready():
	for i in range(slots):
		inventory[i] = null

func get_slot(index):
	return inventory[index]

func remove_slot(index):
	emit_signal("update")
	inventory[index] = null

func add_to_slot(item, x):
	emit_signal("update")
	inventory[x] = item

func get_first_empty_slot():
	for index in range(inventory.size()):
		if inventory[index] == null:
			return index
	return null

func add_to_first_empty_slot(item):
	var pos = get_first_empty_slot()
	if pos != null:
		emit_signal("update")
		add_to_slot(item, pos)

func get_gold():
	return gold

func add_gold(value):
	gold += value