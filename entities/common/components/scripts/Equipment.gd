extends Node

signal update

var Equipment = {
	Global.ARMOUR_TYPE.HEAD : null,
	Global.ARMOUR_TYPE.BODY : null,
	Global.ARMOUR_TYPE.FEET : null,
	Global.ARMOUR_TYPE.LEFT_RING : null,
	Global.ARMOUR_TYPE.RIGHT_RING : null,
	Global.ARMOUR_TYPE.WEAPON : null
}

func set_equipment(new_item, slot):
	for key in Equipment.keys():
		if slot == key:
			Equipment[key] = new_item
	emit_signal("update")