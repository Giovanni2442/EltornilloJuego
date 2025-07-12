extends Timer

@export var scrap_scene: PackedScene
@export var player_scene: PackedScene

func _on_ScrapTimer_timeout():
	var scrap = scrap_scene.instantiate()
#	var player = player_scene.instantiate()
	
	scrap.position = Vector2(randi() % 500, -50)
	if Game.score >= 0 and Game.score <=29:
		wait_time = 0.395
		start()
		scrap.gravity_scale = 0.275
		Game.speed = 475
	if Game.score >= 20 and Game.score <= 30:
		#print("FASE 2")		
		wait_time = 0.285
		start()
		scrap.gravity_scale = 0.375
		Game.speed = 525
		#print($ScrapTimer.wait_time," : ",scrap.gravity_scale)
	
	elif Game.score >= 30 and Game.score <= 45:
		wait_time = 0.255
		start()
		scrap.gravity_scale = 0.535
		Game.speed = 550
	
	elif Game.score >= 45 and Game.score <= 100:		
		wait_time = 0.215
		start()
		scrap.gravity_scale = 0.715
		Game.speed = 580
		#print($ScrapTimer.wait_time," : ",scrap.gravity_scale)
	add_child(scrap)
