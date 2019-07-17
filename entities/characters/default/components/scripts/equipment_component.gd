extends Node

class_name EquipmentComponent

signal equiped_item
signal unequiped_item
signal update
var equipment = {}

func _init():
	for equipment_type in Global.EQUIPMENT_TYPE:
		print(equipment_type)
		self.equipment[Global.EQUIPMENT_TYPE[equipment_type]] = null


func equip(new_item: ItemObject, slot: int):
	new_item.equipped = true
	equipment[slot] = new_item
	print(get_parent().name)
	var inv : InventoryComponent = get_parent().inventory
	for key in inv.inventory.keys():
		if inv.inventory[key] == new_item:
			inv.remove_slot(key)
	emit_signal("update", slot)

func can_unequip(slot: int):
	if get_parent().inventory.get_first_empty_slot() != null:
		return true

func unequip(slot: int):
	var temp_item = equipment[slot]
	var inventory = get_parent().inventory
	var new_slot = inventory.get_first_empty_slot()
	if new_slot != null:
		temp_item.equipped = false
		inventory.add_to_slot(temp_item, new_slot)
		equipment[slot] = null
		emit_signal("update", slot)