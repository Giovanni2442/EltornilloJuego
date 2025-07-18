extends TextureButton

# REDIRICCIÓNA AL MENU PRINCIPAL
func _on_pressed() -> void:	
	Game.new_game.emit()
	get_tree().change_scene_to_file("res://main/Main_menu.tscn")
