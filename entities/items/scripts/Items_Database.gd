extends Node

var ITEM = Global.ITEM
var STAT = Global.STAT
var ARMOUR_TYPE = Global.ARMOUR_TYPE
# Database
var ImageDatabase = {
	"health_potion_01" : load("res://entities/items/sprites/health_potion_01-export.png"),
	"sword_01" : load("res://entities/items/sprites/sword_01.png"),
	"ring_01" : load("res://entities/items/sprites/ring_01.png"),
	"armour_01" : load("res://entities/items/sprites/armour.png")
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
		"type" : ITEM.WEAPON,
		"name" : "Sword",
		"description" : "Basic Sword",
		"icon" : ImageDatabase.sword_01,
		"armour_points" : 5,
		"stat_bonus" : [
			{
				"stat" : STAT.STRENGTH,
				"amount" : 2
			}
		]
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
		"type" : ITEM.ARMOUR,
		"name" : "ChestPlate",
		"description" : "Generic ChestPlate",
		"icon" : ImageDatabase.armour_01,
		"armour_type" : ARMOUR_TYPE.BODY
	}
}