extends Node

signal goto_main_menu
signal goto_dungeon

var wizard
var warrior
var elf
var camera

func _ready():
	wizard = $wizard
	warrior = $warrior
	elf = $elf

func _on_elf_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		set_character(elf)

func _on_warrior_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		set_character(warrior)

func _on_wizard_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		set_character(wizard)

func _on_character_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		set_character($character)

func set_character(character):
	var player = get_parent().get_node("Player")
	player.add_child(player.main_ui)
	if player.sprite:
		player.sprite.IS_PLAYER = false
		player.sprite.set_animation("default")
	player.sprite = character
	player.sprite.IS_PLAYER = true
	player.sprite.set_animation("default")
	player.sprite.start_animation()
	player.sprite.connect("container_opened", player, "open_container_ui")
	player.sprite.connect("container_closed", player, "close_container_ui")
	player.sprite.connect("can_access", player, "set_interact_prompt")
	player.sprite.connect("moving_scene", player.main_ui, "_set_menu")
	player.sprite.stats.connect("stat_updated", player, "update_ui")
	camera = get_parent().get_node("camera")
	camera.set_follower(player.sprite)
	player.main_ui.clear_container_windows()
	player.update_ui()
	#camera.align()

func _on_to_exit_entity_entered(body, to_node):
	emit_signal("goto_main_menu")

func _on_to_start_game_entity_entered(body, to_node):
	var player = get_parent().get_node("Player")
	remove_child(player.sprite)
	emit_signal("goto_dungeon")
	

