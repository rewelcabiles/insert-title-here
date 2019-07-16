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

func _connect_rooms(room1, room2, direction):
	var door_1
	var door_2
	if direction == Global.NORTH:
		door_1 = room_list[room1].place_door(Global.NORTH)
		door_2 = room_list[room2].place_door(Global.SOUTH)
	elif direction == Global.SOUTH:
		door_1 = room_list[room1].place_door(Global.SOUTH)
		door_2 = room_list[room2].place_door(Global.NORTH)
	elif direction == Global.EAST:
		door_1 = room_list[room1].place_door(Global.EAST)
		door_2 = room_list[room2].place_door(Global.WEST)
	elif direction == Global.WEST:
		door_1 = room_list[room1].place_door(Global.WEST)
		door_2 = room_list[room2].place_door(Global.EAST)
	door_1.connected_door_object = door_2
	door_2.connected_door_object = door_1
	
