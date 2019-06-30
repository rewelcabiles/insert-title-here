extends CanvasLayer

export(int) var life_bar setget set_lifebar_hp
export(int) var mana_bar setget set_manabar_mp
export(int) var strength setget set_strength
export(int) var magic setget set_magic
export(int) var agility setget set_agility

var player
var inventory_open = false

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

func reset_center():
	for child in get_node("Center").get_children():
		child.queue_free()
	get_node("Center").visible = false
		
func _on_Inventory_Button_pressed():
	reset_center()
	get_node("Center").visible = true
	if inventory_open == false:
		var inventory_menu = load("res://ui/ui_components/inventory.tscn").instance()
		inventory_menu.initialize_container(player.sprite.inventory)
		get_node("Center").add_child(inventory_menu)
		inventory_open = true
	if inventory_open == true:
		inventory_open = false
	
	
