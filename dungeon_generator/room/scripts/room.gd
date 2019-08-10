extends Node2D

var doors = []
var room_num

func add_door(new_door):
	doors.append(new_door)
	add_child(new_door)

func get_tile_map():
	return $wall