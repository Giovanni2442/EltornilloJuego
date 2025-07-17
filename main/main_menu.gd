extends Node

func control():
	Game.play_game.connect(playLevel)
	
func playLevel():
	get_tree().change_scene_to_file("res://level/main.tscn")


func _ready():
	control()
