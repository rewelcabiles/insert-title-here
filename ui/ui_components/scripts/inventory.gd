extends MarginContainer

var SlotObject = preload("res://ui/ui_components/scripts/ItemSlot.gd")
var ItemObject = preload("res://ui/ui_components/scripts/Item.gd")

var inventory

var SlotList = {}

func _ready():
	pass

func initialize_container(inv):
	inventory = inv
	#inventory.connect("update", self, "update_container")
	for index in range(inventory.inventory.size()):
		var new_slot = SlotObject.new(index)
		new_slot.connect("slot_update", self, "update_inventory")
		SlotList[index] = new_slot
		get_node("GridContainer").add_child(new_slot)
	update_container()
	
func update_container():
	for index in range(inventory.inventory.size()):
		if inventory.inventory[index]:
			var new_item = ItemObject.new(inventory.inventory[index], index)
			SlotList[index].setItem(new_item)
			
func update_inventory(index):
	var slot = SlotList[index]
	var item = null if slot.item == null else slot.item
	inventory.add_to_slot(item, index)