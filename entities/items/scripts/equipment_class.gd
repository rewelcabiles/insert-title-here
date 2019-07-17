extends "res://entities/items/scripts/item_class.gd"



var equipment_type
var stat_bonus = []
var equipped = false

func on_use(user: Character):
	if !equipped:
		if !user.equipment.equipment[equipment_type]:
			print(user.name)
			user.equipment.equip(self, equipment_type)
		else:
			if user.equipment.can_unequip(equipment_type):
				user.equipment.unequip(equipment_type)
				user.equipment.equip(self, equipment_type)
	else:
		if user.equipment.can_unequip(equipment_type):
			user.equipment.unequip(equipment_type)