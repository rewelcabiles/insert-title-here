extends "res://entities/interactable_objects/common/scripts/InteractableObject.gd"

var connected_door_object
var facing

signal entity_entered

func sprite_setter(new_value):
	sprite.texture = new_value

func interacted_by(p_other):
	emit_signal("entity_entered", p_other, connected_door_object)

func _set_sprite(sprite, fv = false, fh=false):
	$Sprite.texture = sprite
	if fv:
		$Sprite.flip_v = true
	if fh:
		$Sprite.flip_h = true