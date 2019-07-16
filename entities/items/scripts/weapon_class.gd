extends "res://entities/items/scripts/equipment_class.gd"

var SwordObject = load("res://entities/items/animations/sword_animation.tscn")

var damage
var weapon_type
var can_swing = true
var combo_count = 1
var combo_window = false
var attack = null
var attack_container = null

func activate(character, location):
	if attack != null:
		attack_container.queue_free()
		attack.queue_free()
		attack_container = null
		attack = null
	attack_container = Node2D.new()
	attack = SwordObject.instance()		
	attack.connect("attack_finished", self, "attack_finished")
	attack.connect("combo_window", self, "add_to_combo")
	attack.connect("combow_window_finished", self, "reset_combo")
	attack.connect("hit", self, "hit_body")
	attack.sprite = icon
	attack_container.add_child(attack)
	character.get_parent().add_child(attack_container)
	attack.activate(character, location)
		
	if combo_window:
		print(">> COMBO : ", str(combo_count))
		if combo_count == 3:
			combo_count = 1
		else:
			combo_count += 1
		var animator :AnimationPlayer = attack.get_node("Area2D/AnimationPlayer") 
		animator.play(str(combo_count))

func hit_body(body):
	var health = body.stats.take_damage(2)

func reset_combo():
	combo_window = false
	combo_count = 1

func add_to_combo():
	combo_window = true
	
func attack_finished(attack_container):
	combo_window = false
	combo_count = 1
	attack_container.get_parent().remove_child(attack_container)
	attack_container = null
	attack = null