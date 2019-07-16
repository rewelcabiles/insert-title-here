extends "res://entities/items/scripts/item_class.gd"

var buffs = []

func on_use(user):
	if "buff_list" in user:
		for buff in buffs:
			user.buff_list.append(buff)
	.on_use(user)

