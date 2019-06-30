extends TextureRect

var slotIndex;
var item = null;

signal slot_update

func _init(slotIndex):
	self.slotIndex = slotIndex;
	name = "ItemSlot_%d" % slotIndex
	texture = preload("res://ui/main_ui/assets/ability_bar_icon_bg.png");
	mouse_filter = Control.MOUSE_FILTER_PASS;
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND;

func get_drag_data(position):
	get_parent().set_drag_preview(item)
	if item != null:
		#set_drag_preview(item)
		return self

func can_drop_data(position, data):
	return true

func drop_data(position, data):
	print(item)
	if item:
		print("Dropped Slot Has Item")
		var temp_item = item
		remove_child(temp_item)
		data.remove_child(data.item)
		add_child(data.item)
		item = data.item
		data.add_child(temp_item)
		data.item = temp_item
		
	elif not item:
		print("Dropped Slot No Item")
		data.remove_child(data.item)
		add_child(data.item)
		item = data.item
		data.item = null
		
	emit_signal("slot_update", slotIndex)
	data.emit_signal("slot_update", data.slotIndex)

func setItem(newItem):
	add_child(newItem);
	item = newItem;
	
func removeItem(item):
	remove_child(item)
	item = null

func pickItem():
	item.pickItem();
	remove_child(item);
	get_parent().get_parent().add_child(item);
	item = null;

func putItem(newItem):
	item = newItem;
	item.itemSlot = self;
	item.putItem();
	get_parent().get_parent().remove_child(item);
	add_child(item);
