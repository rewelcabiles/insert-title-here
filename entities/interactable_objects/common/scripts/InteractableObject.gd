extends StaticBody2D

onready var sprite = $Sprite

func interacted_by(p_other):
	pass

func on_body_enter(body):
	pass

func on_body_exit(body):
	pass
	
func _on_AccessArea_body_entered(body):
	if "can_access" in body:
		body.can_access = self

func _on_AccessArea_body_exited(body):
	if "can_access" in body:
		body.can_access = null
