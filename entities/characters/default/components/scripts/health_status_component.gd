extends Sprite

onready var heart_textures = {
	0: preload("res://entities/characters/default/components/sprites/heart_01.png"),
	1: preload("res://entities/characters/default/components/sprites/heart_02.png"),
	2: preload("res://entities/characters/default/components/sprites/heart_03.png"),
	3: preload("res://entities/characters/default/components/sprites/heart_04.png")
}

func set_texture(index):
	texture = heart_textures[index]