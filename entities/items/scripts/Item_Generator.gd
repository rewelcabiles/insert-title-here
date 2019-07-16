extends Node

var Armour_Object = preload("res://entities/items/scripts/armour_class.gd")
var Consumable_Object = preload("res://entities/items/scripts/consumable_class.gd")
var Weapon_Object = preload("res://entities/items/scripts/weapon_class.gd")
var Equipment_Object = preload("res://entities/items/scripts/equipment_class.gd")

var Database = Item_Database
var Type = Database.TYPE

func Create_Item(index):
	if !Database.ItemDatabase.has(index):
		print("NOT THERE")
		return null
	var new_item
	var item_data = Database.ItemDatabase[index]
	
	match item_data.type:
		Global.ITEM.CONSUME:
			new_item = Create_Consumable(item_data)	
		Global.ITEM.EQUIPMENT:
			if item_data.equipment_type == Global.EQUIPMENT_TYPE.WEAPON:
				new_item = Create_Weapon(item_data)
			else:
				new_item = Create_Equipment(item_data)
	return new_item

func Create_Weapon(item_data):
	var new_weapon = Weapon_Object.new()
	new_weapon.type = item_data.type
	new_weapon.name = item_data.name
	new_weapon.description = item_data.description
	new_weapon.icon = item_data.icon
	new_weapon.equipment_type = item_data.equipment_type
	new_weapon.stat_bonus = item_data.stat_bonus
	new_weapon.damage = item_data.damage
	new_weapon.weapon_type = item_data.weapon_type
	return new_weapon
	
func Create_Equipment(item_data):
	var new_equipment = Equipment_Object.new()
	new_equipment.type = item_data.type
	new_equipment.name = item_data.name
	new_equipment.description = item_data.description
	new_equipment.icon = item_data.icon
	new_equipment.equipment_type = item_data.equipment_type
	new_equipment.stat_bonus = item_data.stat_bonus
	return new_equipment

func Create_Consumable(item_data):
	var new_consumable = Consumable_Object.new()
	new_consumable.type = item_data.type
	new_consumable.name = item_data.name
	new_consumable.description = item_data.description
	new_consumable.icon = item_data.icon
	new_consumable.buffs= item_data.buffs
	return new_consumable