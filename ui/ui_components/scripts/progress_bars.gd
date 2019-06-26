extends HBoxContainer

export(int) var value setget update_bar_number

func _ready():
	pass
	
func update_bar_number(new_num):
	get_node("Count/Background/Number").text = str(new_num)+"%"
	get_node("Count/TextureProgress").value = new_num