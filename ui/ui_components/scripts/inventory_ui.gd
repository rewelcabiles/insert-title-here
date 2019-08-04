extends MarginContainer

var SlotObject = preload("res://ui/ui_components/slot_ui.tscn")
var ItemObject = preload("res://ui/ui_components/scripts/item_ui.gd")

var inventory
var SlotList
var instance

signal close_window



func initialize_container(inv, inv_name):
	var label = get_node("MarginContainer/VBoxContainer/Label")
	var grid  = get_node("MarginContainer/VBoxContainer/GridContainer")
	inv.connect("update", self, "update_ui_slot")
	label.text = inv_name
	inventory = inv
	SlotList = {}
	
	for child in grid.get_children():
		grid.remove_child(child)
		
	for index in range(inventory.inventory.size()):
		var new_slot = SlotObject.instance()
		new_slot.slotIndex = index
		new_slot.connect("slot_update", self, "update_container_slot")
		new_slot.connect("slot_clicked", self, "slot_clicked")
		SlotList[index] = new_slot
		grid.add_child(new_slot)
	update_container()
	
func update_container():
	var grid  = get_node("MarginContainer/VBoxContainer/GridContainer")
	for child in grid.get_children():
		child.removeItem()
		
	for key in inventory.inventory.keys():
		if inventory.inventory[key]:
			var itemHolder = ItemObject.new(inventory.inventory[key], key)
			SlotList[key].setItem(itemHolder)

func update_ui_slot(index):
	if inventory.inventory[index] != null:
		var itemHolder = ItemObject.new(inventory.inventory[index], index)
		SlotList[index].setItem(itemHolder)
	else: 
		SlotList[index].removeItem()

func update_container_slot(index):
	var slot = SlotList[index]
	var item = null if slot.itemHolder == null else slot.itemHolder.itemData
	inventory.add_to_slot(item, index)
	
signal slot_clicked

func slot_clicked(index):
	print("Slot Clicked! 2")
	emit_signal("slot_clicked", index)