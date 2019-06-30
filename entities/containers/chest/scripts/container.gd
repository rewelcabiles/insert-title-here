extends StaticBody2D

var gold = 0 # how much gold does the interacter get from opening this?
export(Texture) var closed_sprite = load("res://entities/containers/chest/sprites/chest_01.png")
export(Texture) var open_sprite = load("res://entities/containers/chest/sprites/chest_02.png")

onready var sprite = $sprite # an image, yay
onready var inventory = $Inventory

func _ready():
	pass

func interacted_by(p_other):
	if not p_other: # if someone is trolling us, don't bother responding
		return
	sprite.texture = open_sprite
	var other_inventory = p_other.get_inventory() if p_other.has_method("get_inventory") else null
	if p_other.has_method("open_container"):
		p_other.open_container(inventory)
		
