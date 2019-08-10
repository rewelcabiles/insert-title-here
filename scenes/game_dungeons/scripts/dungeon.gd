extends Node2D

signal _go_to_main

var Char_Select_Scene = load("res://scenes/game_character_select/character_select.tscn")
var dungeon_generator = load("res://dungeon_generator/generator/generator.tscn").instance()
var char_select_node
var room_list = {}
var door_list = {}
var new_room
var current_room

onready var player = $Player
onready var room_creator = preload("res://scenes/game_dungeons/scripts/room_creator.gd").new()

func _ready():
	char_select_node = Char_Select_Scene.instance()
	char_select_node.connect("goto_dungeon", self, "start_game")
	char_select_node.connect("goto_main_menu", self, "_go_to_menu")
	transition.connect("halfway",self,"_on_transition_halfway")
	Global.PLAYER = $Player
	add_child(char_select_node)

func _go_to_menu():
	char_select_node.queue_free()
	$camera.queue_free()
	player.queue_free()
	emit_signal("_go_to_main")

func start_game():
	dungeon_generator.generate_dungeon()
	transition.fade_to(self, dungeon_generator.starting_floor, char_select_node, true)
	current_room = dungeon_generator.starting_floor
	var floor_vectors = current_room.get_node("floor").get_used_cells()
	var spawn = floor_vectors[int(rand_range(0, floor_vectors.size()))] * 64
	player.sprite.position = spawn
	current_room.add_child(player.sprite)
	var doors = get_tree().get_nodes_in_group("doors")
	for floor_num in dungeon_generator.floors.keys():
		var floor_ = dungeon_generator.floors[floor_num]
		for room in floor_:
			for door in room.doors:
				print("ey")
				door.connect("entity_entered", self, "transition_entity")
	
func transition_entity(target_entity, connected_door_object):
	print("Transitioning!")
	if target_entity.IS_PLAYER:
		$camera.pause = true
		transition.fade_to(self, connected_door_object.get_parent(), current_room)
		current_room = connected_door_object.get_parent()
		print(current_room.room_num)
		
	target_entity.get_parent().remove_child(target_entity)
	connected_door_object.get_parent().add_child(target_entity)
	var tm = target_entity.get_parent().get_tile_map()
	target_entity.set_position(tm.map_to_world(connected_door_object.tile_position + _get_offset(connected_door_object)))

func _on_transition_halfway():
	if $camera:
		$camera.pause = false

func _get_offset(door_object):
	var offset = 1
	match door_object.facing:
		Global.NORTH: 
			return Vector2(0, offset)
		Global.SOUTH:
			return Vector2(0, -offset)
		Global.EAST:
			return Vector2(-offset, 0)
		Global.WEST:
			return Vector2(offset, 0)