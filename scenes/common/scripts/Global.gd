extends Node

export var NORTH = 0
export var EAST = 1
export var SOUTH = 2
export var WEST = 3

export var FLOOR_AUTO_TILES = 4
export var EDGE_AUTO_TILES = 6
export var WALL_AUTO_TILES = 2

export var EQUIP_HEAD = 0
export var EQUIP_BODY = 1
export var EQUIP_FEET = 2
export var EQUIP_LEFT_HAND = 3
export var EQUIP_RIGHT_HAND = 4
export var EQUIP_LEFT_RING = 5
export var EQUIP_RIGHT_RING = 6

enum ITEM{ALL, WEAPON, ARMOUR, CONSUME}
enum ARMOUR_TYPE{HEAD, BODY, FEET, LEFT_RING, RIGHT_RING, WEAPON}

enum STAT{STRENGTH, MAGIC, AGILITY, SPEED, MAX_HEALTH, MAX_MANA}