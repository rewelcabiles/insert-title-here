extends CanvasLayer

export(int) var life_bar setget set_lifebar_hp
export(int) var mana_bar setget set_manabar_mp
export(int) var strength setget set_strength
export(int) var magic setget set_magic
export(int) var agility setget set_agility

var player

signal value_change

func _ready():
	pass

func set_strength(new_num):
	get_node("MarginContainer/TopLeft/Stats/strength/NinePatchRect/Label").text = str(new_num)
	
func set_magic(new_num):
	get_node("MarginContainer/TopLeft/Stats/magic/NinePatchRect/Label").text = str(new_num)
	
func set_agility(new_num):
	get_node("MarginContainer/TopLeft/Stats/agility/NinePatchRect/Label").text = str(new_num)

func set_manabar_mp(new_num):
	get_node("bars/bars/Bars/mp_bar").update_bar_number(new_num)
	
func set_lifebar_hp(new_num):
	get_node("bars/bars/Bars/life_bar").update_bar_number(new_num)
	
func set_slot(slot, texture):
	get_node("ability_bar/bar/slot_"+str(slot)).set_slot(texture)

func select_slot(slot):
	get_tree().call_group("ability_slots", "toggle_select", int(slot))


