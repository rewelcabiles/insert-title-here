extends MarginContainer

var SlotObject = preload("res://ui/ui_components/scripts/ItemSlot.gd")
var ItemObject = preload("res://ui/ui_components/scripts/Item.gd")

var inventory
var SlotList
var instance

func initialize_container(inv, inv_name):
	var label = get_node("MarginContainer/VBoxContainer/HBoxContainer/Label")
	var grid  = get_node("MarginContainer/VBoxContainer/GridContainer")
	label.text = inv_name
	inventory = inv
	SlotList = {}
	
	for child in grid.get_children():
		child.queue_free()
		
	for index in range(inventory.inventory.size()):
		var new_slot = SlotObject.new()
		new_slot.slotIndex = index
		new_slot.connect("slot_update", self, "update_inventory")
		SlotList[index] = new_slot
		grid.add_child(new_slot)
	update_container()
	
func update_container():
	for index in range(inventory.inventory.size()):
		if inventory.inventory[index]:
			var itemHolder = ItemObject.new(inventory.inventory[index], index)
			SlotList[index].setItem(itemHolder)
			
func update_inventory(index):
	var slot = SlotList[index]
	var item = null if slot.itemHolder == null else slot.itemHolder.itemData
	inventory.add_to_slot(item, index)

signal close_window

func _on_close_pressed():
	emit_signal("close_window", name)
