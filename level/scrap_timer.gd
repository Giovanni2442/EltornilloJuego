extends Timer

@export var scrap_scene: PackedScene
@export var player_scene: PackedScene

func _on_ScrapTimer_timeout():
	var scrap = scrap_scene.instantiate()
#	var player = player_scene.instantiate()
	scrap.position = Vector2(randi() % 500, -50)
	if Game.score >= 0 and Game.score <=29:
		wait_time = 0.385		#VELOCIDAD DE ELEMENTOS AL CAER
		start()
		scrap.gravity_scale = 0.275
		Game.speed = 475			#VELOCIDAD DEL JUGADOR
	if Game.score >= 20 and Game.score <= 30:
		#print("FASE 2")		
		wait_time = 0.320		#VELOCIDAD DE ELEMENTOS AL CAER
		start()
		scrap.gravity_scale = 0.375
		Game.speed = 525			#VELOCIDAD DEL JUGADOR
		#print($ScrapTimer.wait_time," : ",scrap.gravity_scale)

	if Game.score >= 30 and Game.score <= 45:
		wait_time = 0.255		#VELOCIDAD DE ELEMENTOS AL CAER
		start()
		scrap.gravity_scale = 0.538
		Game.speed = 550			#VELOCIDAD DEL JUGADOR
	
	if Game.score >= 45:		
		wait_time = 0.235
		start()
		scrap.gravity_scale = 0.645
		Game.speed = 580
		#print($ScrapTimer.wait_time," : ",scrap.gravity_scale)
	add_child(scrap)
