extends CanvasLayer

signal newGame;

# ACTUALIZA LA PUNTUACIÓN
func update_score(score):
	$ScoreLabel.text = str(score)
#DISMINUYE LA BARRA DE SALUD	
func damage(damage):
	$HealthyBarPlayer.value -= damage
#RETORNA LA SALUD DEL JUGADOR ACTUAL
func value_health() -> int:
	return $HealthyBarPlayer.value
	
func heal(heal):
	$HealthyBarPlayer.value += heal
		
#RESETAR LA BARRA DE SALUD DEL JUGADOR
func restart_health():
	$HealthyBarPlayer.value = 100
