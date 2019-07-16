extends "res://entities/interactable_objects/common/scripts/InteractableObject.gd"


export(Texture) var closed_sprite = load("res://entities/containers/chest/sprites/chest_01.png")
export(Texture) var open_sprite = load("res://entities/containers/chest/sprites/chest_02.png")
onready var inventory = $Inventory

var accessed_by = []

func remove_from_accessed(body):
	accessed_by.remove(accessed_by.find(body))

func interacted_by(p_other):
	sprite.texture = open_sprite
	var other_inventory = p_other.get_inventory() if p_other.has_method("get_inventory") else null
	if p_other.has_method("open_container"):
		p_other.open_container(self)
		accessed_by.append(p_other)
		
