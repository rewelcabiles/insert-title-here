extends TextureRect

var ItemObject = preload("res://ui/ui_components/scripts/item_ui.gd")

var equipment

signal close_window

onready var equipment_dict = {
	Global.EQUIPMENT_TYPE.HEAD : $Grid/Head,
	Global.EQUIPMENT_TYPE.BODY : $Grid/Body,
	Global.EQUIPMENT_TYPE.FEET : $Grid/Feet,
	Global.EQUIPMENT_TYPE.RING : $Grid/Ring,
	Global.EQUIPMENT_TYPE.NECKLACE : $Grid/Necklace,
	Global.EQUIPMENT_TYPE.HANDS : $Grid/Hands,
	Global.EQUIPMENT_TYPE.WEAPON : $Grid/Weapon,
	Global.EQUIPMENT_TYPE.SHIELD : $Grid/Shield
}
	

func _ready():
	name = "Equipment"
	if equipment:
		equipment.connect("update", self, "update_ui_slot")
		for key in equipment_dict.keys():
			equipment_dict[key].initialize(key)
			equipment_dict[key].connect("slot_update", self, "update_container_slot")
			equipment_dict[key].connect("Slot_Clicked", self, "update_ui_slot")
	update_container()
	
func update_container():
	for slots in equipment_dict.keys():
		for child in equipment_dict[slots].get_children():
			equipment_dict[slots].remove_child(child)
			
	var Equipment = equipment.equipment
	for key in Equipment.keys():
		if Equipment[key]:
			var itemHolder = ItemObject.new(Equipment[key], key)
			equipment_dict[key].setItem(itemHolder)

func update_ui_slot(index):
	if equipment.equipment[index] != null:
		var itemHolder = ItemObject.new(equipment.equipment[index], index)
		equipment_dict[index].setItem(itemHolder)
	else: 
		equipment_dict[index].removeItem()

func update_container_slot(index: int):
	var slot = equipment_dict[index]
	var item = null if slot.itemHolder == null else slot.itemHolder.itemData
	equipment.equip(item, index)

func click_slot(index: int):
	var slot = equipment_dict[index]
	var item = slot.itemHolder.itemData
	item.on_use(Global.player.sprite)
	




