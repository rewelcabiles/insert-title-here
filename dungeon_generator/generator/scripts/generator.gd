extends Node

var floors = {}
var starting_floor 

var stairs_object = load("res://entities/interactable_objects/stairs/stairs_object.tscn")

func generate_dungeon():
	var total_floors = 5
	for floor_number in range(total_floors):
		floors[floor_number] = $floor_generator.create()
		if floors.size() == 1:
			continue
		connect_floors(floors[floor_number-1], floors[floor_number ])
	starting_floor = floors[0][0]
	
func connect_floors(floor_1, floor_2):
	var floor_1_exit = floor_1[-1]
	var floor_2_entrance = floor_2[0]
	
	var f1 = floor_1_exit.get_node("floor")
	var f2 = floor_2_entrance.get_node("floor")
	
	var valid_floor_1_stairs_position = get_valid_stair_position(f1)
	var valid_floor_2_stairs_position = get_valid_stair_position(f2)
	
	var stairs_instance_1 = stairs_object.instance()
	var stairs_instance_2 = stairs_object.instance()
	
	stairs_instance_1.connected_door_object = stairs_instance_2
	stairs_instance_2.connected_door_object = stairs_instance_1
	
	stairs_instance_1.tile_position = valid_floor_1_stairs_position[rand_range(0, valid_floor_1_stairs_position.size())]
	stairs_instance_2.tile_position = valid_floor_2_stairs_position[rand_range(0, valid_floor_2_stairs_position.size())]
	
	stairs_instance_1.position = f1.map_to_world(stairs_instance_1.tile_position)
	stairs_instance_2.position = f1.map_to_world(stairs_instance_2.tile_position)
	
	stairs_instance_1.direction = "down"
	stairs_instance_2.direction = "up"
	
	stairs_instance_1.update_sprite()
	stairs_instance_2.update_sprite()
	
	floor_1_exit.add_door(stairs_instance_1)
	floor_2_entrance.add_door(stairs_instance_2)

func get_valid_stair_position(room): # Needs 1 tile space below 
	var valid_stairs = []
	var all_vectors = [
		Vector2(-1, -1),
		Vector2(0, -1),
		Vector2(1, -1),
		Vector2(-1, 0),
		Vector2(1, 0),
		Vector2(-1, 1),
		Vector2(0, 1),
		Vector2(1, 1)
	]
	var all_floor_cells = room.get_used_cells()
	for floor_coords in all_floor_cells:
		var valid = true
		for vectors in all_vectors:
			if not floor_coords + vectors in all_floor_cells:
				valid = false
		if valid:
			valid_stairs.append(floor_coords)
	return valid_stairs