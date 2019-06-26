extends Sprite

signal splash_timer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Timer_timeout():
	print("2")
	emit_signal("splash_timer")
