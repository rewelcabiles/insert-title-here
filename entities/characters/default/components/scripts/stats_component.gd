extends Node

class_name StatsComponent

signal stat_updated

const Stat = preload("res://entities/characters/default/components/scripts/stat.gd")

export(int) var max_mana = 10
export(int) var mana = 10
export(int) var max_health = 20
export(int) var health = 20
export(int) var strength = 1
export(int) var magic = 1
export(int) var agility = 1
export(int) var speed = 250

var active_stat_boosts = []

func set_stat(stat_name, new_value):
	match stat_name:
		Global.STAT.HEALTH:
			health = new_value
		Global.STAT.MAX_HEALTH:
			max_health = new_value
		Global.STAT.MANA:
			mana = new_value
		Global.STAT.MAX_MANA:
			max_mana = new_value
		Global.STAT.STRENGTH:
			strength = new_value
		Global.STAT.MAGIC:
			magic = new_value
		Global.STAT.AGILITY:
			agility = new_value
		Global.STAT.SPEED:
			speed = new_value
	emit_signal("stat_updated", stat_name, self)
	
func take_damage(damage):
	var amount = health - damage
	set_stat(Global.STAT.HEALTH, amount)