extends Node2D

signal _go_to_main

var Char_Select_Scene = load("res://scenes/game_character_select/character_select.tscn")
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
	add_child(char_select_node)

func _go_to_menu():
	char_select_node.queue_free()
	$camera.queue_free()
	player.queue_free()
	
	emit_signal("_go_to_main")

func start_game():
	var room_id_1 = room_creator._create_room(self)
	var room_id_2 = room_creator._create_room(self)
	var room_id_3 = room_creator._create_room(self)
	var room_id_4 = room_creator._create_room(self)
	var room_id_5 = room_creator._create_room(self)
	room_creator._connect_rooms(room_id_1, room_id_2, Global.NORTH)
	room_creator._connect_rooms(room_id_1, room_id_3, Global.WEST)
	room_creator._connect_rooms(room_id_1, room_id_4, Global.EAST)
	room_creator._connect_rooms(room_id_1, room_id_5, Global.SOUTH)
	transition.fade_to(self, room_creator.room_list[room_id_1], char_select_node, true)
	current_room = room_creator.room_list[room_id_1]
	player.sprite.position = Vector2(100, 100)
	room_creator.room_list.values()[0].add_child(player.sprite)
	
func transition_entity(target_entity, connected_door_object):
	if target_entity.IS_PLAYER:
		$camera.pause = true
		transition.fade_to(self, connected_door_object.get_parent(), current_room)
		current_room = connected_door_object.get_parent()
	target_entity.get_parent().remove_child(target_entity)
	connected_door_object.get_parent().add_child(target_entity)
	var tm = target_entity.get_parent()._get_tile_map()
	var temp_pos = tm.world_to_map(connected_door_object.position / 4)
	target_entity.set_position(tm.map_to_world(temp_pos + connected_door_object._get_offset()) * 4)

func _on_transition_halfway():
	if $camera:
		$camera.pause = false

