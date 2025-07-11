extends Timer

@export var coins_scene: PackedScene

func _on_CoinTimer_timeout() -> void:
	var coin = coins_scene.instantiate()
	# X : NUMERO ALEATORIO 0-399 , Y : -50(por encima de la pantalla)
	coin.random_coin()
	coin.position = Vector2(randi() % 500, -50) 	# randi()	: Genera un numero entero largo
	add_child(coin)
