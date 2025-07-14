extends Button

func _on_ButtonPressed() -> void:
	Game.new_game.emit()			#emite señal al ser precionado el boton
