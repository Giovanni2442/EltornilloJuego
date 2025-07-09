extends CanvasLayer

# ACTUALIZA LA PUNTUACIÓN
func update_score(score):
	$ScoreLabel.text = str(score)
	
func damage(damage):
	$HealthPlayer.value -= damage
	
