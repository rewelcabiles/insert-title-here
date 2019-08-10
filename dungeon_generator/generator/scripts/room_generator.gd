extends Node

var room_object = load("res://dungeon_generator/room/room.tscn")

func _ready():
	#create_room("drunkard_walk")
	pass

func create_room(method):
	var grid
	if method == "drunkard_walk":
		grid = $drunkard_walk.create()
	if method == "rectangular":
		grid = $rectangular.create("small")
	
	var room_instance = room_object.instance()
	var tile_node
	for x in range(grid.size()):
		for y in range(grid[x].size()):
			if grid[x][y] == Global.TILES.EMPTY:
				continue
			elif grid[x][y] == Global.TILES.FLOOR:
				tile_node = "floor"
			elif grid[x][y] == Global.TILES.WALL:
				tile_node = "wall"
			room_instance.get_node(tile_node).set_cell(x, y, grid[x][y])
			room_instance.get_node(tile_node).update_bitmask_area(Vector2(x, y))
	return room_instance