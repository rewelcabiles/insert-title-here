extends CanvasLayer

export(int) var life_bar setget set_lifebar_hp
export(int) var mana_bar setget set_manabar_mp

onready var items_window = get_node("TopLeft/Items")

var player
var menus = {
	"current" : null,
	"inventory" : load("res://ui/ui_components/inventory.tscn"),
	"equipment" : load("res://ui/ui_components/equipment.tscn")
}

var open_container_menus = []



func set_manabar_mp(new_num):
	get_node("TopLeft/Bars/bars/Bars/mp_bar").update_bar_number(new_num)
	
func set_lifebar_hp(new_num):
	get_node("TopLeft/Bars/bars/Bars/life_bar").update_bar_number(new_num)
	
func select_slot(slot):
	get_tree().call_group("ability_slots", "toggle_select", int(slot))
		
func _on_Inventory_Button_pressed():
	var window = window_is_open("Inventory")
	if window == null:
		var inv = create_container_window(player.sprite.inventory, "Inventory")
		items_window.move_child(inv, 0)
	else:
		close_container_window(window.name)
	window = window_is_open("Equipment")
	if window == null:
		var new_window = menus["equipment"].instance()
		new_window.equipment = player.sprite.equipment
		open_container_menus.append(new_window)
		items_window.add_child(new_window)
	else:
		close_container_window(window.name)

func _on_container_open(container):
	if window_is_open("Inventory") == null:
		var inv = create_container_window(player.sprite.inventory, "Inventory")
		items_window.move_child(inv, 0)
	var window = window_is_open(container.name)
	if window == null:
		var con = create_container_window(container.inventory, container.name)
		connect("remove_from_container_accessed", container, "remove_from_accessed")
	else:
		close_container_window(window.name)

func window_is_open(window_name):
	for window in open_container_menus:
		if window.name == window_name:
			return window
	return null

signal remove_from_container_accessed

func close_container_window(window_name):
	for window in open_container_menus:
		if window.name == window_name:
			items_window.remove_child(window)
			open_container_menus.remove(open_container_menus.find(window))
			emit_signal("remove_from_container_accessed", player.sprite)
			
func clear_container_windows():
	for window in open_container_menus:
		close_container_window(window.name)

func create_container_window(container_inventory, container_name):
	var new_window = menus["inventory"].instance()
	new_window.connect("close_window", self, "close_container_window")
	new_window.initialize_container(container_inventory, container_name)
	new_window.name = container_name
	open_container_menus.append(new_window)
	items_window.add_child(new_window)
	return new_window
