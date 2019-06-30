extends Node

export var character = "warrior"
export var state = "default"

export var speed = 250  # How fast the player will move (pixels/sec).
var velocity
var sprite
var IS_PLAYER = true
var main_ui
var camera
var do_interact
var raycast
var previous_highlight = null
var selectable_distance = 80

func _ready():
	main_ui = $main_ui
	main_ui.player = self
	remove_child($main_ui)

func open_container_ui(other_inventory):
	main_ui

func _physics_process(delta):
	var intersections

	if sprite:
		var x2 = get_parent().get_global_mouse_position()
		var r= selectable_distance*(x2-sprite.position).normalized() + sprite.position
		var mouse_pos = get_parent().get_global_mouse_position()
		var state = get_parent().get_world_2d().get_direct_space_state()
		intersections = state.intersect_ray(sprite.position, r, [sprite], sprite.collision_mask,true, true)
		if not intersections:
			if previous_highlight and is_instance_valid(previous_highlight):
				print("Resetting highlights")
				previous_highlight.modulate = Color(1, 1, 1)
				previous_highlight = null
			else:
				previous_highlight = null

		if intersections:
			if intersections.collider != previous_highlight and not intersections.collider is TileMap:
				if previous_highlight:
					previous_highlight.modulate = Color(1, 1, 1)
				intersections.collider.modulate = Color(1, 0, 1)
				previous_highlight = intersections.collider
		if do_interact:
			do_interact = false
			if intersections and not intersections.collider is TileMap:
				print(intersections)
				var other = intersections["collider"]
				if other.has_method("interacted_by"): # is it an interactable?
					other.interacted_by(sprite) # let the interactable handle the logic
			else:
				sprite.activate_skill(get_parent().get_global_mouse_position())

func _unhandled_input(event):
	if sprite:
		if event is InputEventMouseButton:
			if event.button_index == BUTTON_LEFT and event.pressed:
				do_interact = true

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


func _process(delta):
	if sprite:
		set_ui_info()

func set_ui_info():
	$main_ui.set_strength(sprite.strength)
	$main_ui.set_magic(sprite.magic)
	$main_ui.set_agility(sprite.agility)
	$main_ui.set_lifebar_hp(sprite.health/sprite.max_health * 100)
	$main_ui.set_manabar_mp(sprite.mana/sprite.max_mana * 100)
	#$main_ui.get_node("Inventory_Panel/Inventory_Margin/Inventory").setup_inventory_menu(sprite)