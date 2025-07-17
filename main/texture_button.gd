extends TextureButton

func _on_Start_pressed() -> void:
	Game.play_game.emit()
