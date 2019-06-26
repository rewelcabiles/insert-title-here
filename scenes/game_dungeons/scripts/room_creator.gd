extends Node

var Room_Object = load("res://scenes/game_dungeons/room.tscn")

var new_room
var room_list = {}

func _create_room(parent):
	new_room = Room_Object.instance()
	new_room.connect("door_entered", parent, "transition_entity")
	randomize()
	var room_id
	while true:
		room_id = floor(rand_range(1, 400))
		if not room_list.has(room_id):
			new_room._create_room(room_id)
			room_list[room_id] = new_room
			break
	return room_id

func get_room_list():
	return room_list

func _connect_rooms(room1, room2, direction):
	var door_1
	var door_2
	if direction == Global.NORTH:
		door_1 = room_list[room1].place_door(Global.NORTH, room2)
		door_2 = room_list[room2].place_door(Global.SOUTH, room1)
	elif direction == Global.SOUTH:
		door_1 = room_list[room1].place_door(Global.SOUTH, room2)
		door_2 = room_list[room2].place_door(Global.NORTH, room1)
	elif direction == Global.EAST:
		door_1 = room_list[room1].place_door(Global.EAST, room2)
		door_2 = room_list[room2].place_door(Global.WEST, room1)
	elif direction == Global.WEST:
		door_1 = room_list[room1].place_door(Global.WEST, room2)
		door_2 = room_list[room2].place_door(Global.EAST, room1)
	door_1.connect_door(door_2)
	door_2.connect_door(door_1)
	
func transition_entity(body, connected_door_object):
	var target_entity = body.get_parent()
	var target_room = connected_door_object.get_parent()
	var current_room= target_entity.get_parent()
	var tm = target_room._get_tile_map()
	current_room.remove_child(target_entity)
	target_room.add_child(target_entity)
	
	var temp_pos = tm.world_to_map(connected_door_object.position / 4)
	var new_position
	var offset_amount = 1
	if connected_door_object.facing == Global.NORTH:
		new_position = tm.map_to_world(temp_pos + Vector2(0, offset_amount))
	elif connected_door_object.facing == Global.SOUTH:
		new_position = tm.map_to_world(temp_pos + Vector2(0, -offset_amount))
	elif connected_door_object.facing == Global.EAST:
		new_position = tm.map_to_world(temp_pos + Vector2(-offset_amount, 0))
	elif connected_door_object.facing == Global.WEST:
		new_position = tm.map_to_world(temp_pos + Vector2(offset_amount, 0))
	target_entity.sprite.position = new_position * 4