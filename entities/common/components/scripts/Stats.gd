extends Node

signal update

const Stat = preload("res://entities/common/components/scripts/Stat.gd")

# === Health
export(int) var max_health = Stat.new() setget set_max_health,get_max_health
func set_max_health(new_var):
	max_health.base = new_var
	emit_signal("stat_updated")
	
func get_max_health():
	return max_health.stat
	
export(int) var health = max_health.stat setget,get_health
func get_health():
	return health

# === Mana	
export(int) var max_mana = Stat.new() setget set_max_mana, get_max_mana
func set_max_mana(new_var):
	max_mana.base = new_var
	emit_signal("stat_updated")
	
func get_max_mana():
	return max_mana.stat

export(int) var mana = max_mana.stat setget,get_mana
func get_mana():
	return mana
	
# === Strength	
export(int) var strength = Stat.new() setget set_strength, get_strength
func set_strength(new_var):
	strength.base = new_var
	emit_signal("stat_updated")
func get_strength():
	return strength.stat

# === Magic
export(int) var magic = Stat.new() setget set_magic, get_magic
func set_magic(new_var):
	magic.base = new_var
	emit_signal("stat_updated")
func get_magic():
	return magic.stat	

# === Agility
export(int) var agility = Stat.new() setget set_agility, get_agility
func set_agility(new_var):
	agility.base = new_var
	emit_signal("stat_updated")
func get_agility():
	return agility.stat

# === Speed
export(int) var speed = Stat.new() setget set_speed, get_speed
func set_speed(new_var):
	speed.base = new_var
	emit_signal("stat_updated")
func get_speed():
	return speed.stat




	





	


