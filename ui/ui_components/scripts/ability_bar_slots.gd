extends MarginContainer

var selected = false
export(int) var slot_number
export(Texture) var default_bg = load("res://ui/main_ui/assets/ability_bar_icon_bg.png")
export(Texture) var select_bg = load("res://ui/main_ui/assets/ability_bar_icon_bg_selected.png")


func _ready():
	mouse_filter = Control.MOUSE_FILTER_PASS;
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND;

func set_slot(texture):
	$icon.texture = texture

func toggle_select(value):
	if slot_number == value:
		if selected == true:
			$background.texture = default_bg
			selected = false
		else:
			$background.texture = select_bg
			selected = true
	else:
		$background.texture = default_bg
		selected = false
