extends CanvasLayer

var new_room
var old_room
var root
var free = false

signal halfway

func fade_to(root, newscene, oldscene, free = false):
	self.root = root
	self.free = free
	old_room = oldscene
	new_room = newscene
	get_node("transition/animator").play("fade")
	
func change_scene():
	if new_room and root:
		if old_room:
			root.remove_child(old_room)
		root.add_child(new_room)
		if free and old_room:
			old_room.queue_free()
		emit_signal("halfway")
		free = false
		root = null
		old_room = null
		new_room = null