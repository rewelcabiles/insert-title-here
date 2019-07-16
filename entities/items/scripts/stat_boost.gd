extends Node

var boost_name
var description
var duration
var stat
var amount

var timer
var current_affecting :StatsComponent = null

func _init(new_name, new_description, new_duration, new_stat, new_amount):
	name = new_name
	description = new_description
	duration = new_duration
	stat = new_stat
	amount = new_amount
	
	if duration != null:
		timer = Timer.new()
		timer.one_shot = true
		timer.set_wait_time(duration)
		timer.connect("timeout", self, "remove_stat")

func apply_stat(stats :StatsComponent):
	current_affecting = stats
	current_affecting.stat_dict[stat] += amount

func remove_stat(stats):
	current_affecting.stat_dict[stat] -= amount
	current_affecting = null
