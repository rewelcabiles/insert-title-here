extends Control

var body

func _process(delta):
	if body != null:
		var transform = body.get_global_transform_with_canvas().origin
		rect_position.x = transform.x
		rect_position.y = transform.y

func _ready():
	var key_name
	for action in InputMap.get_action_list("interact"):
		key_name = OS.get_scancode_string(action.scancode)
	$MarginContainer/MarginContainer/Label.text = key_name