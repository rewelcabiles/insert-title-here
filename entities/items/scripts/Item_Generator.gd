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

	if item_data.itemType == Type.Consumable:
		new_item = Create_Consumable(item_data)
	
	if item_data.itemType == Type.Weapon:
		new_item = Create_Weapon(item_data)
	
	return new_item

func Create_Armour():
	var pieces = ["head", "body", "legs", "left_ring", "right_ring", "shield"]
	var new_armour = Armour_Object.new()

func Create_Weapon(item_data):
	var new_weapon = Consumable_Object.new()
	new_weapon.type = item_data.itemType
	new_weapon.name = item_data.itemName
	new_weapon.description = item_data.itemDesc
	new_weapon.icon = item_data.itemIcon
	#new_weapon.buffs= item_data.itemBuffs
	return new_weapon
	
func Create_Consumable(item_data):
	var new_consumable = Consumable_Object.new()
	new_consumable.type = item_data.itemType
	new_consumable.name = item_data.itemName
	new_consumable.description = item_data.itemDesc
	new_consumable.icon = item_data.itemIcon
	new_consumable.buffs= item_data.itemBuffs
	return new_consumable