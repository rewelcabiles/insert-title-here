extends TextureRect

var itemIcon
var itemName
var itemSlot
var itemData

func _init(item, slot_index):
	itemData = item
	name = itemData.name
	itemIcon = itemData.icon
	texture = itemData.icon
	itemName = itemData.name
	hint_tooltip = "Name: %s\n\n %s" % [itemData.name, itemData.description]
	itemSlot = slot_index
	mouse_filter = Control.MOUSE_FILTER_PASS;
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND