extends KinematicBody2D

signal skill_selected
signal skill_activated

onready var movement = load("res://entities/common/scripts/movement.gd").new()

export(PackedScene) var primary_skill

export var max_health = 20
export var health = 20
export var max_mana = 10
export var mana = 10
export var strength = 5
export var magic = 5
export var agility = 5
export var speed = 250

export var idle = "default"
export var moving = "run"

var buff_list = []
var IS_PLAYER = false
var velocity

var sprite
#Stats
onready var stats = load("res://entities/common/scripts/stats.gd").new()

# Inventory
onready var inventory = $Inventory
func get_inventory():
	return inventory

signal container_opened

func open_container(other_inventory):
	emit_signal("container_opened", other_inventory)

# Abilities
export(Script) var ability_book = load("res://abilities/magic_abilities/spell_book/mage_spell_book.gd").new() setget set_skills
func activate_skill(location):
	print("Activating Skill!")
	if ability_book.current_skill == null:
		ability_book.current_skill = ability_book.primary_skill
	var skill = ability_book.current_skill.instance()
	get_parent().add_child(skill)
	skill.activate(self, location)

func select_skill(index):
	ability_book.current_skill = ability_book.quick_bar[index]
	emit_signal("skill_selected", index)

func set_skills(script):
	ability_book = script.new()
	print(ability_book.book_name)

func get_position():
	return position

func set_position(new_pos):
	position = new_pos

func _process(delta):
	velocity = Vector2()
	if movement.RIGHT:
		velocity.x += 1
	if movement.LEFT:
		velocity.x -= 1
	if movement.DOWN:
		velocity.y += 1
	if movement.UP:
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	else:
		sprite.set_animation(idle)
	if velocity.x != 0:
		sprite.set_animation(moving)
		flip_h(velocity.x < 0)
	move_and_slide(velocity)


func _ready():
	stats.set_entity(self)
	sprite = $sprite
	inventory.add_to_first_empty_slot(Item_Generator.Create_Item(0))
	inventory.add_to_first_empty_slot(Item_Generator.Create_Item(1))
	

func move_to_scene(scene):
	get_parent().remove_child(self)
	scene.add_child(self)

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
