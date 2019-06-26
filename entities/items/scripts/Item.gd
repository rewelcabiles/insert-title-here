extends Resource

var name
var description
var value
var use_name
var durability
var type
var icon

func on_use(user):
	if durability == 0:
		pass