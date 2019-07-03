extends StaticBody2D

var gold = 0 # how much gold does the interacter get from opening this?
var open = false
export(Texture) var closed_sprite = load("res://entities/containers/chest/sprites/chest_01.png")
export(Texture) var open_sprite = load("res://entities/containers/chest/sprites/chest_02.png")

onready var sprite = $sprite
onready var inventory = $Inventory

signal opened

var accessed_by = []

func _ready():
	name = "container"
	inventory.add_to_first_empty_slot(Item_Generator.Create_Item(0))

func interacted_by(p_other):
	if not p_other:
		return
	sprite.texture = open_sprite
	var other_inventory = p_other.get_inventory() if p_other.has_method("get_inventory") else null
	if p_other.has_method("open_container"):
		p_other.open_container(self)
		accessed_by.append(p_other)

func _on_Access_Area_body_exited(body):
	if body in accessed_by:
		remove_from_accessed(body)
		body.close_container(self)

func remove_from_accessed(body):
	accessed_by.remove(accessed_by.find(body))
