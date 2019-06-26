extends Node

var book_name = "Magic Book"
var current_skill 
var selected_skill
var quick_bar = {1: null, 2: null, 3: null, 4: null}
var primary_skill = load("res://abilities/magic_abilities/basic_attack/basic_magic.tscn")
var secondary_skill = load("res://abilities/magic_abilities/basic_attack/basic_magic.tscn")

func set_quick_bar(index, spell):
	quick_bar[index] = spell

func get_quick_bar(index):
	return quick_bar[index]

func get_primary():
	return primary_skill
	
func get_secondary():
	return secondary_skill
	
func _set_current_skill(skill):
	current_skill = skill

func _ready():
	pass
	
