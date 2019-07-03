extends Node

var UP = false
var DOWN = false
var LEFT = false
var RIGHT = false

var velocity

func set_flag(direction, value):
	if direction == "up":
		UP = value
	if direction == "down":
		DOWN = value
	if direction == "left":
		LEFT = value
	if direction == "right":
		RIGHT = value

func update_velocity():
	velocity = Vector2()
	if RIGHT:
		velocity.x += 1
	if LEFT:
		velocity.x -= 1
	if DOWN:
		velocity.y += 1
	if UP:
		velocity.y -= 1
	return velocity

func reset():
	UP = false
	DOWN = false
	LEFT = false
	RIGHT = false