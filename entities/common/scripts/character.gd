extends KinematicBody2D

class_name Character

signal skill_selected

var movement = load("res://entities/characters/default/components/scripts/movement_component.gd").new()

export var idle = "default"
export var moving = "run"

var IS_PLAYER = false
var velocity
var sprite

func _ready():
	sprite = $sprite
	stats.connect("stat_updated", self, "on_stat_updated")
	inventory.add_to_first_empty_slot(Item_Generator.Create_Item(0))
	inventory.add_to_first_empty_slot(Item_Generator.Create_Item(1))
	inventory.add_to_first_empty_slot(Item_Generator.Create_Item(2))
	inventory.add_to_first_empty_slot(Item_Generator.Create_Item(3))

# =======================Stats
onready var stats = $Stats
onready var health_status = $HealthStatus
func on_stat_updated(stat_name):
	print("OOF1")
	if stat_name == Global.STAT.HEALTH:
		print("OOF2")
		var percent = stats.health / stats.max_health * 100.0
		print(percent)
		if percent > 90:
			health_status.set_texture(0)
		elif percent > 50:
			health_status.set_texture(1)
		elif percent > 20:
			health_status.set_texture(3)
		elif percent > 0:
			health_status.set_texture(4)
# =======================Interactables

var can_access = null

func interact_object():
	print("Starting Interact Function!")
	if can_access:
		print("Can Access!")
		can_access.interacted_by(self)

# =======================Inventory and Containers
onready var inventory := $Inventory
onready var equipment := $Equipment

func get_inventory():
	return inventory

signal container_opened
signal container_closed

func open_container(container):
	emit_signal("container_opened", container)

func close_container(container):
	emit_signal("container_closed", container)

# =======================Abilities
export(Script) var ability_book = load("res://abilities/magic_abilities/spell_book/mage_spell_book.gd").new() setget set_skills
func activate_skill(location):
	if equipment.Equipment[Global.EQUIPMENT_TYPE.WEAPON] != null:
		equipment.Equipment[Global.EQUIPMENT_TYPE.WEAPON].activate(self, location)
	#ability_book.current_skill = ability_book.primary_skill
	#var skill = ability_book.current_skill.instance()
	#get_parent().add_child(skill)
	#skill.activate(self, location)

func select_skill(index):
	ability_book.current_skill = ability_book.quick_bar[index]
	emit_signal("skill_selected", index)

func set_skills(script):
	ability_book = script.new()
	print(ability_book.book_name)


# =======================BUFFS
func process_buffs():
	pass


func _physics_process(delta):
	velocity = movement.update_velocity()
	if velocity.length() != 0:
		pass
		#velocity = velocity.normalized() * stats.get_stat(Global.STAT.SPEED)
	else:
		sprite.set_animation(idle)
	if velocity.x != 0:
		sprite.set_animation(moving)
		flip_h(velocity.x < 0)
	move_and_slide(velocity)
	

# =======================OTHER
func get_position():
	return position

func set_position(new_pos):
	position = new_pos

signal moving_scene

func move_to_scene(scene):
	get_parent().remove_child(self)
	scene.add_child(self)
	emit_signal("moving_scene")

func start_animation():
	$sprite.play()

func stop_animation():
	$sprite.stop()

func set_animation(animation):
	$sprite.animation = animation

func flip_v(state):
	$sprite.flip_v = state

func flip_h(state):
	$sprite.flip_h = state
