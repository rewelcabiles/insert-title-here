extends "res://entities/interactable_objects/common/scripts/InteractableObject.gd"

var on = true

func interacted_by(p_other):
	if on == true:
		on = false
	else:
		on = true
	
	$RedFlame.emitting = on
	$YellowFlame.emitting = on
	$WhiteFlame.emitting = on
	$Light2D.enabled = on
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
