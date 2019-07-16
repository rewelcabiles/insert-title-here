extends Node

var ITEM = Global.ITEM
var STAT = Global.STAT
var EQUIPMENT_TYPE = Global.EQUIPMENT_TYPE
# Database
var ImageDatabase = {
	"health_potion_01" : load("res://entities/items/sprites/health_potion_01-export.png"),
	"sword_01" : load("res://entities/items/sprites/sword_01.png"),
	"ring_01" : load("res://entities/items/sprites/ring_01.png"),
	"armour_01" : load("res://entities/items/sprites/armour.png"),
	"sword_02" : load("res://entities/items/sprites/sword_02.png")
}

var TYPE = {
	"Weapon" : 0,
	"Armour" : 1,
	"Consumable" : 2
}

var database = {
	0 : {
		"itemName" : "Ring",
		"itemIcon" : ImageDatabase.ring_01
	}
}

var ItemDatabase = {
	0 : {
		"type" : ITEM.EQUIPMENT,
		"name" : "Sword",
		"description" : "Basic Sword",
		"icon" : ImageDatabase.sword_01,
		"equipment_type" : EQUIPMENT_TYPE.WEAPON,
		"weapon_type" : Global.WEAPON_TYPE.SWORD,
		"damage" : 4,
		"stat_bonus" : []
	},
	1 : {
		"type" : ITEM.CONSUME,
		"name" : "Health Potion",
		"description" : "Heals for 10 Points of Health, Yum!",
		"icon" : ImageDatabase.health_potion_01,
		"buffs": [
			{
				"applies_to" : "health",
				"amount" : 10,
				"type" : "instant"
			}
		],
		"itemDurability" : 1
	},
	2 : {
		"type" : ITEM.EQUIPMENT,
		"name" : "ChestPlate",
		"description" : "Generic ChestPlate",
		"icon" : ImageDatabase.armour_01,
		"equipment_type" : EQUIPMENT_TYPE.BODY,
		"stat_bonus" : []
	},
	3 : {
		"type" : ITEM.EQUIPMENT,
		"name" : "Dark Sword",
		"description" : "Its a basic sword, but darker",
		"icon" : ImageDatabase.sword_02,
		"equipment_type" : EQUIPMENT_TYPE.WEAPON,
		"weapon_type" : Global.WEAPON_TYPE.SWORD,
		"damage" : 4,
		"stat_bonus" : []
	},
}