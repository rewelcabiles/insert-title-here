extends Node2D

var follow_target
var pause = false

func _process(delta):
	if not pause:
		if follow_target:
			set_position(follow_target.position)
			$camera.align()
			
func set_follower(f):
	follow_target = f


func _ready():
	pass
