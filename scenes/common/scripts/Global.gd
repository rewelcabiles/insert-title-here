extends Node

export var NORTH = 0
export var EAST = 1
export var SOUTH = 2
export var WEST = 3

export var FLOOR_AUTO_TILES = 4
export var EDGE_AUTO_TILES = 6
export var WALL_AUTO_TILES = 2
var PLAYER
enum ITEM{ALL=3, EQUIPMENT, CONSUME}
enum EQUIPMENT_TYPE{HEAD=3, BODY, HANDS, FEET, RING, NECKLACE, WEAPON, SHIELD}
enum STAT{STRENGTH=3, MAGIC, AGILITY, SPEED, MAX_HEALTH, MAX_MANA, MANA, HEALTH}
enum WEAPON_TYPE{SWORD=3, SPEAR}