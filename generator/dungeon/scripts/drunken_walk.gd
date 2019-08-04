extends Node

var x
var y

func create_grid(size_x, size_y):
	var grid = []
	for x in range(size_x):
		grid.append([])
		grid[x].resize(size_y)
		for y in range(size_y):
			grid[x][y] = Global.TILE.WALL
	return grid

func create_level(x_size, y_size):
	x = x_size
	y = y_size
	var amount = 100
	var grid = create_grid(x, y)
	var walked = []	
	var current
	while true:
		current = Vector2(randi() % x - 1, randi() % y - 1)
		if (current.x > 0 and current.x < x) and (current.y > 0 and current.y < y):
			walked.append(current)
			break 
	
	while walked.size() < amount:
		randomize()
		var neighbor = get_neighbor(current, randi() % 4)
		if neighbor == null:
			continue
		current = neighbor
		if not current in walked:
			walked.append(current)
			grid[current.x][current.y] = Global.TILE.FLOOR
	for x in grid.size():
		print(grid[x])

func get_neighbor(current, direction):
	match direction:
		Global.NORTH:
			if current.y == 1:
				return null
			else:
				return Vector2(current.x, current.y - 1)
		Global.SOUTH:
			if current.y == y - 2:
				return null
			else:
				return Vector2(current.x, current.y + 1)
		Global.EAST:
			if current.x == x - 2:
				return null
			else:
				return Vector2(current.x + 1, current.y)
		Global.WEST:
			if current.x == 1:
				return null
			else:
				return Vector2(current.x - 1, current.y)