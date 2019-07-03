extends Node

var Armour_Object = preload("res://entities/items/scripts/Armour.gd")
var Consumable_Object = preload("res://entities/items/scripts/Consumable.gd")
var Weapon_Object = preload("res://entities/items/scripts/Weapon.gd")

var Database = Item_Database
var Type = Database.TYPE

func Create_Item(index):
	if !Database.ItemDatabase.has(index):
		print("NOT THERE")
		return null
	var new_item
	var item_data = Database.ItemDatabase[index]

	if item_data.type == Global.ITEM.CONSUME:
		new_item = Create_Consumable(item_data)
	
	if item_data.type == Global.ITEM.WEAPON:
		new_item = Create_Weapon(item_data)
	
	return new_item

func Create_Armour(item_data):
	var new_armour = Armour_Object.new()
	new_armour.type = item_data.type
	new_armour.name = item_data.name
	new_armour.description = item_data.description
	new_armour.icon = item_data.icon
	new_armour.armour_points = item_data.armour_point
	new_armour.stat_bonus = item_data.stat_bonus
	new_armour.armour_type = item_data.armour_type
	
func Create_Weapon(item_data):
	var new_weapon = Consumable_Object.new()
	new_weapon.type = item_data.type
	new_weapon.name = item_data.name
	new_weapon.description = item_data.description
	new_weapon.icon = item_data.icon
	
	return new_weapon
	
func Create_Consumable(item_data):
	var new_consumable = Consumable_Object.new()
	new_consumable.type = item_data.type
	new_consumable.name = item_data.name
	new_consumable.description = item_data.description
	new_consumable.icon = item_data.icon
	new_consumable.buffs= item_data.buffs
	return new_consumable