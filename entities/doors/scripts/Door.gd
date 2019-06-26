extends StaticBody2D

export(int) var to_node
export(int) var from_node
export(bool) var is_locked = false
export(Texture) var sprite setget sprite_setter

var connected_door_object
var door_id
var facing


signal entity_entered

func sprite_setter(new_value):
	$sprite.texture = new_value

func _process(delta):
	pass
	
func interacted_by(p_other):
	if not p_other: # if someone is trolling us, don't bother responding
		return
	emit_signal("entity_entered", p_other, connected_door_object)
	
func _get_offset():
	var offset = 1
	if facing == Global.NORTH:
		return Vector2(0, offset)
	elif facing == Global.SOUTH:
		return Vector2(0, -offset)
	elif facing == Global.EAST:
		return Vector2(-offset, 0)
	elif facing == Global.WEST:
		return Vector2(offset, 0)

func set_door_id(did):
	door_id = did

func _set_to_node(node_id):
	to_node = node_id
	
func _set_from_node(node_id):
	from_node = node_id

func _set_sprite(sprite, fv = false, fh=false):
	$sprite.texture = sprite
	if fv:
		$sprite.flip_v = true
	if fh:
		$sprite.flip_h = true

func _ready():
	pass

func set_position(vectors):
	position = vectors

func connect_door(door):
	connected_door_object = door

func scale_up(amount):
	transform = transform.scaled(Vector2(amount,amount))	