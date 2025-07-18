extends TextureButton

#REDIRICCIÓNA AL NIVEL 
func _on_pressed() -> void:
	Game.new_game.emit()
	#get_tree().change_scene_to_file("res://level/main.tscn")
