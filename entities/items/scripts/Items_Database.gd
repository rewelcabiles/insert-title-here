extends Node



# Database
var ImageDatabase = {
	"health_potion_01" : load("res://entities/items/sprites/health_potion_01-export.png"),
	"sword_01" : load("res://entities/items/sprites/sword_01.png"),
	"ring_01" : load("res://entities/items/sprites/ring_01.png")
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
		"itemType" : TYPE.Weapon,
		"itemName" : "Sword",
		"itemDesc" : "Basic Sword",
		"itemIcon" : ImageDatabase.sword_01
	},
	1 : {
		"itemType" : TYPE.Consumable,
		"itemName" : "Health Potion",
		"itemDesc" : "Heals for 10 Points of Health, Yum!",
		"itemIcon" : ImageDatabase.health_potion_01,
		"itemBuffs": [
			{
				"health" : 10,
				"type" : "instant"
			}
		],
		"itemDurability" : 1
	}
}