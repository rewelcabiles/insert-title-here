extends Area2D

signal destroy

var running = false
var current_time = 0
export var max_time = 0.5
export var speed = 1000
export var effect_on_impact = true
export(Texture) var impact_sprite
export(Texture) var trail_texture setget set_trail


var target
var direction

func _ready():
	pass

func set_trail(texture):
	pass

func _process(delta):
	position += direction * speed * delta

func _on_AnimatedSprite_animation_finished():
	get_parent().remove_child(self)

func activate(location):
	var spawn = get_parent().sprite.position
	position = spawn
	direction = (location - spawn).normalized()
	rotation = direction.angle()
	$limit.set_wait_time(max_time)
	$limit.start()

func _on_primary_magic_body_entered(body):
	print("Hit > "+body.name)
	if effect_on_impact:
		speed = 20
		$sprite.play()

func _on_limit_timeout():
	print("TIMEOUT")
	$sprite.play()
