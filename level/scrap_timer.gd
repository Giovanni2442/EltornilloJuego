extends Timer

@export var scrap_scene: PackedScene

func _on_ScrapTimer_timeout():
	var scrap = scrap_scene.instantiate()
	scrap.position = Vector2(randi() % 500, -50)
	if Game.score >= 20 and Game.score <= 30:
		#print("FASE 2")
		wait_time
		wait_time = 0.285
		start()
		scrap.gravity_scale = 0.375
		#print($ScrapTimer.wait_time," : ",scrap.gravity_scale)
	
	elif Game.score >= 30 and Game.score <= 45:
		wait_time = 0.255
		start()
		scrap.gravity_scale = 0.535
	
	elif Game.score >= 45 and Game.score <= 100:		
		wait_time = 0.215
		start()
		scrap.gravity_scale = 0.715
		#print($ScrapTimer.wait_time," : ",scrap.gravity_scale)
	add_child(scrap)
