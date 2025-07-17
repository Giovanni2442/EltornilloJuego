extends Timer

@export var coins_scene: PackedScene

func _on_CoinTimer_timeout() -> void:
	var coin = coins_scene.instantiate()
	# X : NUMERO ALEATORIO 0-399 , Y : -50(por encima de la pantalla)
	
	if Game.score >= 0 and Game.score <= 29:
		wait_time = 3.20
	if Game.score >= 30 and Game.score <= 45:
		wait_time = 2.604
	if  Game.score >= 45 and Game.score <= 100:	
		wait_time = 2.258
		
	coin.random_coin()
	coin.position = Vector2(randi() % 500, -50) 	# randi()	: Genera un numero entero largo
	add_child(coin)
