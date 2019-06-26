extends KinematicBody2D

onready var raycast = $RayCast2D
onready var inventory = $Inventory setget , get_inventory # we have a node called "Inventory"
var do_interact = false # a flag to let us know when we need to test with our raycast

func _ready():
	if raycast: # if everything went alright and we found our node
		raycast.add_exception(self) # "Stop hitting yourself"

func _unhandled_input(p_event):
	if Input.input_action_just_pressed("interact"): # are we interacting?
		do_interact = true # let the raycast know it needs to do its thing.

func _physics_process(p_delta):
	if raycast and do_interact:
		do_interact = false # don't re-attempt an interact in the next physics frame unless we need to
		var point_ahead = Vector2(...) # get the location you want to check.
		# get your vector2 with `global_position`
		# get its forward vector
		# add some value along the forward vector to find your new point.
		# I'm not sure on all the mathy logic here. I hate math. Sorry. XD
		raycast.cast_to(point_ahead) # check what's there
		if raycast.is_colliding(): # did we hit something?
			var other = raycast.get_collider() # what did we hit?
			if other.has_method("interacted_by"): # is it an interactable?
				other.interacted_by(self) # let the interactable handle the logic

func get_inventory():
	return inventory