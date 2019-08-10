extends "res://entities/interactable_objects/common/scripts/InteractableObject.gd"

class_name door_object

var connected_door_object
var tile_position
var facing = Global.NORTH

signal entity_entered

var vertical_texture = load("res://entities/interactable_objects/door/sprites/door_south.png")
var horizontal_texture = load("res://entities/interactable_objects/door/sprites/door_east.png")
var default_texture = load("res://entities/interactable_objects/door/sprites/door.png")

func sprite_setter(new_value):
	sprite.texture = new_value

func interacted_by(p_other):
	emit_signal("entity_entered", p_other, connected_door_object)

func update_sprite():
	match facing:
		Global.NORTH:
			$Sprite.texture = default_texture
		Global.WEST:
			$Sprite.texture = horizontal_texture
		Global.EAST:
			$Sprite.texture = horizontal_texture
			$Sprite.flip_h = true
			$Sprite.flip_v = false
		Global.SOUTH:
			$Sprite.texture = vertical_texture
			$Sprite.flip_h = false
			$Sprite.flip_v = true