extends Node

class_name Player

export var character = "warrior"
export var state = "default"

var sprite :Character
var IS_PLAYER = true
var main_ui
var camera

func _ready():
	main_ui = $main_ui
	remove_child($main_ui)

func open_container_ui(container):
	main_ui._on_container_open(container)

func close_container_ui(container):
	main_ui.close_container_window(container.name)

func _unhandled_input(event):
	if sprite:
		if event is InputEventMouseButton:
			if event.button_index == BUTTON_LEFT and event.pressed:
				sprite.activate_skill(get_parent().get_global_mouse_position())
				
func _input(event):
	if sprite:
		if Input.is_action_just_released("interact"):
			if sprite.can_access:
				sprite.interact_object()
			else:
				$main_ui._on_Inventory_Button_pressed()
			
		if Input.is_action_pressed("ui_right"):
			sprite.movement.RIGHT = true
		else:
			sprite.movement.RIGHT = false

		if Input.is_action_pressed("ui_left"):
			sprite.movement.LEFT = true
		else:
			sprite.movement.LEFT = false

		if Input.is_action_pressed("ui_down"):
			sprite.movement.DOWN = true
		else:
			sprite.movement.DOWN = false

		if Input.is_action_pressed("ui_up"):
			sprite.movement.UP = true
		else:
			sprite.movement.UP = false
		
		if Input.is_action_just_pressed("activate_skill_1"):
			sprite.select_skill(1)
			$main_ui.select_slot(1)
		if Input.is_action_just_pressed("activate_skill_2"):
			sprite.select_skill(2)
			$main_ui.select_slot(2)
		if Input.is_action_just_pressed("activate_skill_3"):
			sprite.select_skill(3)
			$main_ui.select_slot(3)
		if Input.is_action_just_pressed("activate_skill_4"):
			sprite.select_skill(4)
			$main_ui.select_slot(4)

func update_ui():
	$main_ui.set_lifebar_hp(sprite.stats.health / sprite.stats.max_health * 100)
	$main_ui.set_manabar_mp(sprite.stats.mana / sprite.stats.max_mana * 100)