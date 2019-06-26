extends Node

var UP = false
var DOWN = false
var LEFT = false
var RIGHT = false

func set_flag(direction, value):
	if direction == "up":
		UP = value
	if direction == "down":
		DOWN = value
	if direction == "left":
		LEFT = value
	if direction == "right":
		RIGHT = value

func reset():
	UP = false
	DOWN = false
	LEFT = false
	RIGHT = false