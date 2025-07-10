extends CanvasLayer

# ACTUALIZA LA PUNTUACIÓN
func update_score(score):
	$ScoreLabel.text = str(score)
	
func damage(damage):
	$HealthyBarPlayer.value -= damage
	
func value_health() -> int:
	return $HealthyBarPlayer.value
