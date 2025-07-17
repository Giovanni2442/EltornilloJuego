extends TextureButton

func _on_pressed() -> void:
	Game.new_game.emit()
