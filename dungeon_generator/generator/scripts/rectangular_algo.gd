extends Node

var sizes = {
	"small" : [5, 10],
	"medium" : [10, 15],
	"large" : [15, 20]
}

func create(size):
	var x_size = rand_range(sizes[size][0], sizes[size][1])
	var y_size = rand_range(sizes[size][0], sizes[size][1])
	var grid = []
	for x in range(x_size):
		grid.append([])
		grid[x].resize(y_size)
		for y in range(y_size):
			if x == 0 or x == int(x_size - 1) or y == 0 or y == int(y_size - 1):
				grid[x][y] = Global.TILES.WALL
			else:	
				grid[x][y] = Global.TILES.FLOOR
	return grid