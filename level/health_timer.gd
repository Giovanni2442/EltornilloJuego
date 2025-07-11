extends Timer

@export var coins_scene: PackedScene

func _on_HealthTimer_timeout() -> void:
	var coinHealth = coins_scene.instantiate()
	coinHealth.coin_health()
	coinHealth.position = Vector2(randi() % 500, -50) 	# randi()	: Genera un numero entero largo
	add_child(coinHealth)
