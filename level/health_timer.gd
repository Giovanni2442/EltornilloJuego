extends Timer

@export var coins_scene: PackedScene

# VELOCIDAD DE REPRODUCCIÓN DE ITEMS 'HEALTH'
func _on_HealthTimer_timeout() -> void:
	var coinHealth = coins_scene.instantiate()
	if Game.score >= 0 and Game.score <= 45:
		wait_time = 25.50	
	if Game.score >= 30 and Game.score <= 45:
		wait_time = 20.20
	if  Game.score >= 45:	
		wait_time = 15.45
		
	coinHealth.coin_health()
	coinHealth.position = Vector2(randi() % 500, -50) 	# randi()	: Genera un numero entero largo
	add_child(coinHealth)
