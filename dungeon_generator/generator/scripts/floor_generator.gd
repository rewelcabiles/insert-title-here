extends Node

var door_object = load("res://entities/interactable_objects/door/door_object.tscn")


func create():
	var rooms = []
	var exits = {}
	var max_rooms = 6
	var room_generator = get_parent().get_node("room_generator")
	rooms.append(room_generator.create_room("rectangular"))
	exits[rooms[-1]] = 0
	rooms[-1].room_num = rooms.size()
	while rooms.size() < max_rooms:
		randomize()
		var unfinished_rooms = []
		for room in exits.keys():
			if exits[room] < 4:
				unfinished_rooms.append(room)
		var current_room = unfinished_rooms[randi() % unfinished_rooms.size()]
		var new_room = room_generator.create_room("drunkard_walk")
		connect_rooms(current_room, new_room, randi() % 4)
		exits[current_room] = exits[current_room] + 1
		exits[new_room] = 1
		rooms.append(new_room)
		new_room.room_num = rooms.size()
	return rooms
	
func connect_rooms(room1, room2, direction):
	var floor1 :TileMap = room1.get_node("floor")
	var floor2 = room2.get_node("floor")
	var wall1 = room1.get_node("wall")
	var wall2 = room2.get_node("wall")
	var all_tiles_1 = floor1.get_used_cells() + wall1.get_used_cells()
	var all_tiles_2 = floor2.get_used_cells() + wall2.get_used_cells()
	var room1_valid_door_position = []
	var room2_valid_door_position = []
	var dir_vectors
	var door_instance_1 = door_object.instance()
	var door_instance_2 = door_object.instance()
	match direction:
		0: # North
			dir_vectors = Vector2(0, -1)
			door_instance_1.facing = Global.NORTH
			door_instance_2.facing = Global.SOUTH
		1: # South
			dir_vectors = Vector2(0, 1)
			door_instance_1.facing = Global.SOUTH
			door_instance_2.facing = Global.NORTH
		2: # East
			dir_vectors = Vector2(1, 0)
			door_instance_1.facing = Global.EAST
			door_instance_2.facing = Global.WEST
		3: # West
			dir_vectors = Vector2(-1, 0)
			door_instance_1.facing = Global.WEST
			door_instance_2.facing = Global.EAST
	
	door_instance_1.update_sprite()
	door_instance_2.update_sprite()
	
	room1_valid_door_position = get_valid_door_positions(wall1, floor1, all_tiles_1, dir_vectors)
	room2_valid_door_position = get_valid_door_positions(wall2, floor2, all_tiles_2, dir_vectors * -1)	
	
	
	door_instance_1.connected_door_object = door_instance_2
	door_instance_2.connected_door_object = door_instance_1
	
	door_instance_1.tile_position = room1_valid_door_position[rand_range(0, room1_valid_door_position.size())]
	door_instance_2.tile_position = room2_valid_door_position[rand_range(0, room2_valid_door_position.size())]
	
	door_instance_1.position = wall1.map_to_world(door_instance_1.tile_position)
	door_instance_2.position = wall2.map_to_world(door_instance_2.tile_position)

	room1.add_door(door_instance_1)
	room2.add_door(door_instance_2)

func get_valid_door_positions(wall, floors, all, vectors):
	var valid_doors = []
	for wall_coords in wall.get_used_cells():
		if not wall_coords + vectors in all and wall_coords + (vectors * -1) in floors.get_used_cells():
			valid_doors.append(wall_coords)
	return valid_doors
	
