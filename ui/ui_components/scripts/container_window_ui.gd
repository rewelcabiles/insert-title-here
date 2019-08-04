extends Node2D

var user_inventory 
var target_inventory 

signal close_window

func _ready():
	$user_inventory.initialize_container(user_inventory, "Inventory")
	$target_inventory.initialize_container(target_inventory, "Container")
	

func _on_TextureButton_pressed():
	emit_signal("close_window", name)


func _on_user_inventory_slot_clicked(index):
	print("Clicked 1")
	var temp_item = user_inventory.inventory[index]
	user_inventory.remove_slot(index)
	target_inventory.add_to_first_empty_slot(temp_item)

func _on_target_inventory_slot_clicked(index):
	var temp_item = target_inventory.inventory[index]
	target_inventory.remove_slot(index)
	user_inventory.add_to_first_empty_slot(temp_item)
