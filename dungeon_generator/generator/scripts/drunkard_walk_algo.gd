extends Node

func _ready():
	create()

func create():
	randomize()
	var x_size = 30
	var y_size = 30
	var grid = []
	for x in range(x_size):
		grid.append([])
		grid[x].resize(y_size)
		for y in range(y_size):
			grid[x][y] = Global.TILES.EMPTY
			
	var walked = []
	var max_visited = 200
	var current = Vector2(int(rand_range(2, x_size - 2)), int(rand_range(2, y_size - 2)))
	walked.append(current)
	while walked.size() < max_visited:
		match randi() % 4:
			0: # North
				if current.y > 1:
					current.y -= 1
			1: # East
				if current.x < x_size - 2:
					current.x += 1
			2: # South
				if current.y < y_size - 2:
					current.y += 1
			3: # West
				if current.x > 1:
					current.x -= 1
		if not current in walked:
			walked.append(current)
			grid[current.x][current.y] = Global.TILES.FLOOR
			add_walls(grid, current)
#	for x in grid.size():
#		print (grid[x])
	return grid
	
func add_walls(grid, current):
	var directions = [
		[-1, -1], [0, -1], [1, -1],
		[-1, 0], [1, 0],
		[-1, 1], [0, 1], [1, 1]
	]
	for dirs in directions:
		var new_current = current + Vector2(dirs[0], dirs[1])
		if grid[new_current.x][new_current.y] != Global.TILES.FLOOR:
			grid[new_current.x][new_current.y] = Global.TILES.WALL