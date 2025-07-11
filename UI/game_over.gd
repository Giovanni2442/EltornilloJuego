extends TileMapLayer

func show_score(score):
	$Score.text = str(score)
	
func _on_button_pressed():
	Game.new_game.emit()			#emite señal al ser precionado el boton
