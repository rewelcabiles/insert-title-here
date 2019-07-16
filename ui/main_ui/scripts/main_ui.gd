extends CanvasLayer

export(int) var life_bar setget set_lifebar_hp
export(int) var mana_bar setget set_manabar_mp

onready var items_window = get_node("Center")
onready var InventoryObject = preload("res://ui/ui_components/inventory_ui.tscn")
onready var EquipmentObject = preload("res://ui/ui_components/equipment_ui.tscn")
onready var CharacterDisplay = preload("res://ui/ui_components/character_info_ui.tscn")
onready var ContainerDisplay = preload("res://ui/ui_components/container_window_ui.tscn")

var open_container_menus = []



func set_manabar_mp(new_num):
	get_node("TopLeft/Bars/bars/Bars/mp_bar").update_bar_number(new_num)
	
func set_lifebar_hp(new_num):
	get_node("TopLeft/Bars/bars/Bars/life_bar").update_bar_number(new_num)
	
func select_slot(slot):
	get_tree().call_group("ability_slots", "toggle_select", int(slot))
		
func _on_Inventory_Button_pressed():
	var window = window_is_open("CharacterDisplay")
	if !window:
		var char_display = CharacterDisplay.instance()
		char_display.connect("close_window", self, "close_container_window")
		char_display.name="CharacterDisplay"
		char_display.character = Global.PLAYER.sprite
		char_display.set_child_info()
		open_container_menus.append(char_display)
		items_window.add_child(char_display)
		get_tree().paused = true
	else:
		close_container_window("CharacterDisplay")

func _on_container_open(container):
	var window = window_is_open("ContainerDisplay")
	if !window:
		var container_display = ContainerDisplay.instance()
		container_display.connect("close_window", self, "close_container_window")
		container_display.name="ContainerDisplay"
		container_display.target_inventory = container.inventory
		container_display.user_inventory = Global.PLAYER.sprite.inventory
		open_container_menus.append(container_display)
		items_window.add_child(container_display)
		get_tree().paused = true
	else:
		close_container_window("ContainerDisplay")
		
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
			emit_signal("remove_from_container_accessed", Global.PLAYER.sprite)
			get_tree().paused = false
			
func clear_container_windows():
	for window in open_container_menus:
		close_container_window(window.name)

func create_container_window(container_inventory, container_name):
	
	var new_window = InventoryObject.instance()
	new_window.connect("close_window", self, "close_container_window")
	new_window.initialize_container(container_inventory, container_name)
	new_window.name = container_name
	open_container_menus.append(new_window)
	items_window.add_child(new_window)
	return new_window
