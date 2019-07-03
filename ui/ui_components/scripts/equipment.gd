extends TextureRect

var ItemObject = preload("res://ui/ui_components/scripts/Item.gd")

var equipment

onready var Head = $Head
onready var Body = $Body
onready var Feet = $Feet
onready var Left_Ring = $Left_Ring
onready var Right_Ring = $Right_Ring
onready var Weapon = $Weapon

onready var equipment_dict = {
	Global.ARMOUR_TYPE.HEAD : Head,
	Global.ARMOUR_TYPE.BODY : Body,
	Global.ARMOUR_TYPE.FEET : Feet,
	Global.ARMOUR_TYPE.LEFT_RING : Left_Ring,
	Global.ARMOUR_TYPE.RIGHT_RING : Right_Ring,
	Global.ARMOUR_TYPE.WEAPON : Weapon
}
	

func _ready():
	name = "Equipment"
	for key in equipment_dict.keys():
		equipment_dict[key].initialize(key)
	update_container()

func initialize_container(equipment, name):
	self.name = "Equipment"
	self.equipment = equipment
	for key in equipment_dict.keys():
		equipment_dict[key].initialize(key)
	update_container()
	
func update_container():
	var Equipment = equipment.Equipment
	for key in Equipment.keys():
		if Equipment[key]:
			var itemHolder = ItemObject.new(Equipment[key], key)
			equipment_dict[key].setItem(itemHolder)

func update_inventory(index):
	for key in equipment_dict.keys():
		if index == key:
			var slot = equipment_dict[key]
			var item = null if slot.itemHolder == null else slot.itemHolder.itemData
			equipment.add_to_slot(item, index)

signal equipment_updated

func equipment_updated():
	emit_signal("equipment_updated")

signal close_window

func _on_close_pressed():
	emit_signal("close_window", name)
