extends Node

func create_room(method):
	if method == "drunken_walk":
		return $drunken_walk.create_level(20, 20)