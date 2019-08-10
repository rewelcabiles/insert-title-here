extends "res://entities/interactable_objects/door/scripts/door_script.gd"

var texture_up = load("res://entities/interactable_objects/stairs/sprites/stairs_01.png")
var texture_down = load("res://entities/interactable_objects/stairs/sprites/stairs_02.png")

var direction

func update_sprite():
	match direction:
		"up":
			$Sprite.texture = texture_up
		"down":
			$Sprite.texture = texture_down
