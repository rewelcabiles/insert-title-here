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

var stat_dict = {
	Global.STAT.MAX_MANA : max_mana,
	Global.STAT.MAX_HEALTH : max_health,
	Global.STAT.HEALTH : health,
	Global.STAT.MANA : mana,
	Global.STAT.STRENGTH : strength,
	Global.STAT.AGILITY : agility,
	Global.STAT.SPEED : speed
}

var active_stat_boosts = []

func stat_update(stat_name):
	emit_signal("stat_updated", stat_name)
	
func take_damage(amount):
	print("OOF")
	stat_update(Global.STAT.HEALTH)
	health -= amount