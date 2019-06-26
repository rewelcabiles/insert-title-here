extends Node

export(int) var gold = 0

var inventory = {}

func _ready():
	for i in range(20):
		inventory[i] = null

func get_slot(index):
	return inventory[index]

func remove_slot(index):
	inventory[index] = null

func add_to_slot(item, x):
	inventory[x] = item

func switch_slots(index_1, index_2):
	var item1 = inventory[index_1]
	var item2 = inventory[index_2]
	inventory[index_1] = item2
	inventory[index_2] = item1

func get_first_empty_slot():
	for index in range(inventory.size()):
		if inventory[index] == null:
			return index
	return null

func add_to_first_empty_slot(item):
	var pos = get_first_empty_slot()
	if pos != null:
		add_to_slot(item, pos)

func get_gold():
	return gold

func add_gold(value):
	gold += value