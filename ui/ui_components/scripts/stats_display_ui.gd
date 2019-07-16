extends Control

var Stats : StatsComponent
var STATS = Global.STAT
var stat_hint_format = """ 
	Base       = {base}
	Added      = {added}
	Multiplier = {mult}
"""


onready var stat_list = {
	Global.STAT.STRENGTH: $MarginContainer/HBoxContainer/StatData/Strength_Stat,
	Global.STAT.MAGIC: $MarginContainer/HBoxContainer/StatData/Magic_Stat,
	Global.STAT.AGILITY: $MarginContainer/HBoxContainer/StatData/Agility_Stat
}

func _ready():
	update_stats()

func update_stats():
	var strength_total = stat_list[STATS.STRENGTH].get_node("StatTotal")
	strength_total.text = str(Stats.strength)
	
	var magic_total = stat_list[STATS.MAGIC].get_node("StatTotal")
	magic_total.text = str(Stats.magic)

	var agility_total = stat_list[STATS.AGILITY].get_node("StatTotal")
	agility_total.text = str(Stats.agility)
