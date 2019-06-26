extends Area2D

signal destroy

var running = false
var current_time = 0
var damage = 2.5
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

func activate(caster, location):
	var spawn = caster.position
	position = spawn
	direction = (location - spawn).normalized()
	rotation = direction.angle()
	$limit.set_wait_time(max_time)
	$limit.start()

func _on_primary_magic_body_entered(body):
	if not body.get("stats") == null:
		body.stats.take_damage(damage)
	speed = 100
	$sprite.play()

func _on_limit_timeout():
	print("TIMEOUT")
	speed = 100
	$sprite.play()
