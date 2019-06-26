extends Node2D


signal door_entered


var center_tile
var room_id
var x_size
var y_size
var Door_Object = load("res://entities/doors/Door.tscn")


func _ready():
	pass
	
func _create_room(r_id):
	room_id = r_id
	$tile_floor.transform = $tile_floor.transform.scaled(Vector2(4,4))	
	$tile_edge.transform = $tile_edge.transform.scaled(Vector2(4,4))	
	$tile_walls.transform = $tile_walls.transform.scaled(Vector2(4,4))	
	randomize()
	x_size = rand_range(10,30)
	y_size = rand_range(10,30)
	center_tile = Vector2(x_size/2, y_size/2)
	#$camera.position = $tile_floor.map_to_world(center_tile) * 4

	# Create Floors
	for x in range(x_size):
		for y in range(y_size):
			$tile_floor.set_cell(x, y, Global.FLOOR_AUTO_TILES)
			$tile_floor.update_bitmask_area(Vector2(x, y))
	
	# Create Walls
	for x in range(x_size):
		$tile_walls.set_cell(x, -1, Global.WALL_AUTO_TILES)
		$tile_walls.update_bitmask_area(Vector2(x, -1))
	
	# Create Wall Edges
	for x in range(-1, x_size+1):
		for y in range(-2, y_size+1):
			$tile_edge.set_cell(x, y, Global.EDGE_AUTO_TILES)
			$tile_edge.update_bitmask_area(Vector2(x, y))

func place_door(direction, to_node=null):
	var x_pos
	var y_pos
	var new_door = Door_Object.instance()
	new_door.to_node = to_node
	new_door.from_node = room_id
	new_door.scale_up(4)
	
	if direction == Global.NORTH:
		new_door.facing = Global.NORTH
		new_door._set_sprite(load("res://entities/doors/sprites/door_"+str(int(rand_range(1, 4)))+".png")) 
		x_pos = rand_range(1, x_size - 1)
		y_pos = -1
		$tile_walls.set_cell(x_pos, y_pos, -1)
	elif direction == Global.SOUTH:
		new_door.facing = Global.SOUTH
		new_door._set_sprite(load("res://entities/doors/sprites/door_v.png")) 
		x_pos = rand_range(1, x_size - 1)
		y_pos = y_size
		$tile_edge.set_cell(x_pos, y_pos, -1)
	elif direction == Global.EAST:
		new_door.facing = Global.EAST
		new_door._set_sprite(load("res://entities/doors/sprites/door_h.png"), false, true)
		x_pos = x_size
		y_pos = rand_range(0, y_size)
		$tile_edge.set_cell(x_pos, y_pos, -1)
	elif direction == Global.WEST:
		new_door.facing = Global.WEST
		new_door._set_sprite(load("res://entities/doors/sprites/door_h.png"))
		x_pos = -1
		y_pos = rand_range(0, y_size)
		$tile_edge.set_cell(x_pos, y_pos, -1)
	
	new_door.set_position($tile_walls.map_to_world(Vector2(x_pos+1, y_pos+1)) * 4 )
	new_door.connect("entity_entered", self, "_door_entered")
	add_child(new_door)
	return new_door
	 
func _get_tile_map():
	return $tile_edge
	
func _door_entered(body, connected_door_object):
	print(body.name + " entered a door")
	emit_signal("door_entered", body, connected_door_object)