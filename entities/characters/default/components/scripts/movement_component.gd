extends Node

var UP = false
var DOWN = false
var LEFT = false
var RIGHT = false
var velocity = Vector2()
var max_speed = 200
var f_accelerate = 800

func update_velocity(delta):
	var accelerate = f_accelerate * delta
	if RIGHT:
		velocity.x += accelerate
	if LEFT:
		velocity.x -= accelerate
	if DOWN:
		velocity.y += accelerate
	if UP:
		velocity.y -= accelerate
	
	if not LEFT and not RIGHT:
		if velocity.x > 0:
			velocity.x += -accelerate * 2
			if velocity.x < 0:
				velocity.x = 0
		elif velocity.x < 0:
			velocity.x += accelerate * 2
			if velocity.x > 0:
				velocity.x = 0

	if not UP and not DOWN:
		if velocity.y > 0:
			velocity.y += -accelerate * 2
			if velocity.y < 0:
				velocity.y = 0
		elif velocity.y < 0:
			velocity.y += accelerate * 2
			if velocity.y > 0:
				velocity.y = 0
	
	velocity.x = max_speed if velocity.x >= max_speed and (LEFT or RIGHT) else velocity.x
	velocity.y = max_speed if velocity.y >= max_speed and (UP or DOWN) else velocity.y

	velocity.x = -max_speed if velocity.x <= -max_speed and (LEFT or RIGHT) else velocity.x
	velocity.y = -max_speed if velocity.y <= -max_speed and (UP or DOWN) else velocity.y

	return velocity


func reset():
	UP = false
	DOWN = false
	LEFT = false
	RIGHT = false