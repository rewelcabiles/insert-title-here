extends Node2D

var user_inventory 
var target_inventory 

signal close_window

func _ready():
	$user_inventory.initialize_container(user_inventory, "Inventory")
	$target_inventory.initialize_container(target_inventory, "Container")
	

func _on_TextureButton_pressed():
	print("Closeing")
	emit_signal("close_window", name)
