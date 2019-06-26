extends Node2D

signal start_pressed
signal options_pressed
signal exit_pressed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.





func _on_button_start_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		emit_signal("start_pressed")


func _on_button_exit_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		emit_signal("exit_pressed")


func _on_button_options_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		emit_signal("options_pressed")
