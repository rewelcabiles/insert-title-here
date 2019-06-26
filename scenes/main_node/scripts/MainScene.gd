extends Node

var scene_splash = load("res://scenes/main_menu/SplashScreen.tscn")
var scene_main_menu = load("res://scenes/main_menu/main_menu.tscn")
var Dungeon_Scene = load("res://scenes/game_dungeons/dungeon.tscn")
var current_scene = null

func _ready():
	# Start Splash Screen
	_create_main_menu()
	
func _create_main_menu():
	var main = scene_main_menu.instance()
	transition.fade_to(self, main, current_scene, true)		
	current_scene = main
	current_scene.connect("start_pressed", self, "_on_start_game")
	current_scene.connect("options_pressed", self, "_on_options")
	current_scene.connect("exit_pressed", self, "_on_exit")
	
func _on_start_game():
	var game = Dungeon_Scene.instance()
	transition.fade_to(self, game, current_scene, true)		
	current_scene = game
	current_scene.connect("_go_to_main", self, "_create_main_menu")
	#add_child(current_scene)

func _on_options():
	pass
	
func _on_exit():
	current_scene.queue_free()
	get_tree().quit()
		
func _on_splash_timer_timeout():
	current_scene.queue_free()
	_create_main_menu()