extends TextureRect

var slotIndex;
var itemHolder = null;
var holds_type = Global.ITEM.ARMOUR

signal slot_update

func _init(slotIndex):
	self.slotIndex = slotIndex;
	name = "ItemSlot_%d" % slotIndex
	texture = preload("res://ui/main_ui/assets/ability_bar_icon_bg.png");
	mouse_filter = Control.MOUSE_FILTER_PASS;
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND;

func get_drag_data(position):
	get_parent().set_drag_preview(itemHolder)
	if itemHolder != null:
		get_parent().get_parent().set_drag_preview(itemHolder)
		return self

func can_drop_data(position, slot):
	var item_type = slot.itemHolder.itemData.type
	if item_type == Global.ITEM.ARMOUR:
		return true

func drop_data(position, data):
	print(itemHolder)
	if itemHolder:
		var temp_item = itemHolder
		remove_child(temp_item)
		data.remove_child(data.itemHolder)
		add_child(data.itemHolder)
		itemHolder = data.itemHolder
		data.add_child(temp_item)
		data.itemHolder = temp_item
		
	elif not itemHolder:
		data.remove_child(data.itemHolder)
		add_child(data.itemHolder)
		itemHolder = data.itemHolder
		data.itemHolder = null
		
	emit_signal("slot_update", slotIndex)
	data.emit_signal("slot_update", data.slotIndex)

func setItem(newItem):
	add_child(newItem);
	itemHolder = newItem;
	
func removeItem(item):
	remove_child(item)
	itemHolder = null
