extends Node

signal update

var entity

func set_entity(e):
	entity = e

func take_damage(damage):
	entity.health -= damage
	emit_signal("update", "damage_taken")
	
func _ready():
	pass
