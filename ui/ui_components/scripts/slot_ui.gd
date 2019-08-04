extends TextureRect

var slotIndex
var itemHolder = null;
export(Global.ITEM) var holds_type = Global.ITEM.ALL
export(Global.EQUIPMENT_TYPE) var equipment_type

signal slot_update
signal slot_clicked

export(Texture) var default_texture = preload("res://ui/ui_components/sprite/equipment_slot_default.png")
var empty_slot_texture = preload("res://ui/ui_components/sprite/equipment_slot_default.png")

func _ready():
	mouse_filter = Control.MOUSE_FILTER_PASS;
	

func initialize(slotIndex):
	self.slotIndex = slotIndex;
	name = "ItemSlot_%d" % slotIndex

func get_drag_data(position):
	if itemHolder != null:
		var preview = TextureRect.new()
		preview.texture = itemHolder.texture
		set_drag_preview(preview)
		return self

func can_drop_data(position, slot):
	var item_type = slot.itemHolder.itemData.type
	# If both slots accept any item type, Return True
	if holds_type == Global.ITEM.ALL and slot.holds_type == Global.ITEM.ALL:
		return true	
	if itemHolder == null and holds_type == Global.ITEM.ALL:
		return true
	# Do we have an item?
	if itemHolder != null:
		# If our items type isn't compatible with the receiving slots type, Return false
		if itemHolder.itemData.type != slot.holds_type:
			return false
		if itemHolder.itemData.type == Global.ITEM.EQUIPMENT:
			if itemHolder.itemData.equipment_type != equipment_type:
				return false
	if item_type != holds_type:
		return false
	if item_type == Global.ITEM.EQUIPMENT:
		if slot.itemHolder.itemData.equipment_type != equipment_type:
			return false
	return true


func drop_data(position, data):
	if itemHolder:
		var temp_item = itemHolder
		itemHolder = data.itemHolder
		data.itemHolder = temp_item
	elif not itemHolder:
		itemHolder = data.itemHolder
		data.itemHolder = null
	emit_signal("slot_update", slotIndex)
	data.emit_signal("slot_update", data.slotIndex)

func setItem(newItem):
	for child in get_children():
		remove_child(child)
	texture = empty_slot_texture
	add_child(newItem)
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	itemHolder = newItem
	
func removeItem():
	itemHolder = null
	texture = default_texture
	mouse_default_cursor_shape = Control.CURSOR_ARROW
	for child in get_children():
		remove_child(child)
		
func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and !event.pressed:
			if itemHolder != null:
				print("Slot Clicked!")
				emit_signal("slot_clicked", slotIndex)
				#itemHolder.itemData.on_use(Global.PLAYER.sprite)