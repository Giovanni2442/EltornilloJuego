extends TextureButton

func _on_Start_pressed() -> void:
	print("Dirigir al nivel")
	Game.play_game.emit()
