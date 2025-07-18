extends Node

func control():
	#Game.main_menu.connect(mainMenu)
	Game.play_game.connect(playLevel)
		
func playLevel():
	get_tree().change_scene_to_file("res://level/main.tscn")

func mainMenu():
	print("Conactar al menu")
	get_tree().change_scene_to_file("res://main/Main_menu.tscn")

func _ready():
	control()
