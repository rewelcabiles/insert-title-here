extends Sprite

var displayed = false

onready var heart_textures = {
	0: preload("res://entities/characters/default/components/sprites/heart_01.png"),
	1: preload("res://entities/characters/default/components/sprites/heart_02.png"),
	2: preload("res://entities/characters/default/components/sprites/heart_03.png"),
	3: preload("res://entities/characters/default/components/sprites/heart_04.png")
}

func on_stat_update(stat_name, stats):
	if stat_name != Global.STAT.HEALTH:
		return
	if displayed == false:
		$AnimationPlayer.play("beat_01")
		displayed = true
	$recently_updated.start(10)
	var percent = float(stats.health) / float(stats.max_health) * 100.0
	if percent > 85:
		texture = heart_textures[0]
		$AnimationPlayer.set_speed_scale(1)
	elif percent > 50:
		texture = heart_textures[1]
		$AnimationPlayer.set_speed_scale(2)
	elif percent > 20:
		texture = heart_textures[2]
		$AnimationPlayer.set_speed_scale(4)
	elif percent > 0:
		texture = heart_textures[3]
		$AnimationPlayer.set_speed_scale(0.5)
	

func _on_recently_updated_timeout():
	displayed = false
	$AnimationPlayer.play("fade_out")
