extends GridContainer

var ItemClass = preload("res://ui/ui_components/scripts/Item.gd");
var ItemSlotClass = preload("res://ui/ui_components/scripts/ItemSlot.gd");
var slotTexture = preload("res://ui/main_ui/assets/ability_bar_icon_bg.png");

var slotList
var itemList
var holdingItem = null;
var inventory

func setup_inventory_menu(other):
	slotList = Array()
	itemList = Array()
	for i in range(0, get_child_count()):
		get_child(i).queue_free()
		
	if other.has_method("get_inventory"):
		inventory = other.get_inventory()
		for i in range(inventory.inventory.size()):
			var slot = ItemSlotClass.new(i);
			slotList.append(slot);
			add_child(slot);
		var index = 0

		for item_index in inventory.inventory:
			var item = inventory.inventory[item_index]
			if item:
				var itemName = item.name;
				var itemIcon = item.icon;
				var new_item = ItemClass.new(itemName, itemIcon, null, item.description)
				new_item.itemData = item
				itemList.append(new_item);
				slotList[index].setItem(new_item)
			index += 1


func _input(event):
	if holdingItem and holdingItem.picked:
		holdingItem.rect_global_position = Vector2(event.position.x, event.position.y);

func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		var clickedSlot;
		#Iterate through all slots
		for slot in slotList:
			# Compare Slot Dimensions with Mouse position on click event
			var slotMousePos = slot.get_local_mouse_position();
			var slotTexture = slot.texture;
			var isClicked = slotMousePos.x >= 0 && slotMousePos.x <= slotTexture.get_width() && slotMousePos.y >= 0 && slotMousePos.y <= slotTexture.get_height();
			# If slot is clicked
			if isClicked:
				clickedSlot = slot;
		if holdingItem and clickedSlot:
			if clickedSlot.item != null:
				var tempItem = clickedSlot.item;
				var oldSlot = slotList[slotList.find(holdingItem.itemSlot)];
				clickedSlot.pickItem();
				inventory.get_slot(clickedSlot.slotIndex)
				inventory.remove_slot(clickedSlot.slotIndex)
				clickedSlot.putItem(holdingItem);
				inventory.add_to_slot(holdingItem.itemData, clickedSlot.slotIndex)
				holdingItem = null;
				oldSlot.putItem(tempItem);
				inventory.add_to_slot(tempItem.itemData, oldSlot.slotIndex)
				
			else:
				clickedSlot.putItem(holdingItem);
				inventory.add_to_slot(holdingItem.itemData, clickedSlot.slotIndex)
				# GLOBAL LIST OF ACTIVE ITEMS AS A SINGLETON
				holdingItem = null;
				
		elif clickedSlot.item != null:
			holdingItem = clickedSlot.item;
			clickedSlot.pickItem();
			inventory.get_slot(clickedSlot.slotIndex)
			inventory.remove_slot(clickedSlot.slotIndex)
			holdingItem.rect_global_position = Vector2(event.position.x, event.position.y);
