extends Node
@export var coins_scene: PackedScene
@export var scrap_scene: PackedScene
@export var gameOver_scene: PackedScene

@export var description: String = "coin"
 
#var score = 0
#var health = 0

#Conecta las señales del Singleton al metodo el juego al ser emitidas
func control():
	Game.new_game.connect(new_game)

# EMPEZAR NUEVO JUEGO
func new_game():
	var gameOver = get_node_or_null("Screen_game_over")		# TOMAR EL NODO YA CREADO EN EL ARBOL DE ESCENAS
	if gameOver:						# VERIFICAR SI EXISTE EL NODO
		gameOver.queue_free()			# ELIMINAR LA PANTALLA DE GAME OVER
	else:
		print("No se pudo eliminar")
	Game.score = 0
	$HUD.update_score(0)		#RESETEAR EL PUNTAJE
	$HUD.restart_health()		#RESETEAR LA SALUD
	main()

# FINALIZAR JUEGO
func game_over(health):
	var gameOver = gameOver_scene.instantiate()		#ISTANCIA A LA PANTALLA GAME OVER
	gameOver.name = "Screen_game_over"				#AGREGAR ETIQUETA LA INSERTARSE AL ARBOL DE ESCENAS
	#print(health)
	if health == 25:
		$Player.hide()
		$Player.queue_free()
		$MusicLevel.stop()
		$ScrapTimer.stop()	
		$CoinTimer.stop()
		gameOver.show_score(Game.score)
		add_child(gameOver)
		$MusicDeadPlayer.play()
		await $MusicDeadPlayer.finished
		
# COLICIONA CON OBJETO
func catch_object(body):
	var nameObject = body.descripcion
	var sprite = body.get_node("AnimatedSprite2D")
	var sound = body.get_node("AudioStreamPlayer2D")
		
	if nameObject == "Coin":
		if sprite.animation != "especial":
			Game.score += 1			
		else : 
			Game.score += 10
		sound.play()
		$HUD.update_score(Game.score)
	else :
		sound.play()		
		Game.damage = 25.5
		$HUD.damage(Game.damage)	
		game_over($HUD.value_health())					
			
	body.visible = false
	await sound.finished
	body.queue_free()
	
#			 --- TEMPORIZADORES --- 
# GENERAR MONEDAS
func _on_Coin_timer_timeout():
	var coin = coins_scene.instantiate()
	# X : NUMERO ALEATORIO 0-399 , Y : -50(por encima de la pantalla)
	coin.random_coin()
	coin.position = Vector2(randi() % 400, -50) 	# randi()	: Genera un numero entero largo
	add_child(coin)
	
# GENERA MONEDAS DE SALUD
func _on_health_timer_timeout():
	var coinHealth = coins_scene.instantiate()
	coinHealth.coin_health()
	coinHealth.position = Vector2(randi() % 400, -50) 	# randi()	: Genera un numero entero largo
	add_child(coinHealth)
	
# GENERAR CHATARRA(Enemigos)
func _on_ScrapTimer_timeout():
	var scrap = scrap_scene.instantiate()
	scrap.position = Vector2(randi() % 500, -50)
	if Game.score >= 20 and Game.score <= 30:
		#print("FASE 2")
		$ScrapTimer.wait_time = 0.285
		$ScrapTimer.start()
		scrap.gravity_scale = 0.375
		print($ScrapTimer.wait_time," : ",scrap.gravity_scale)
	
	elif Game.score >= 30 and Game.score <= 45:
		$ScrapTimer.wait_time = 0.255
		$ScrapTimer.start()
		scrap.gravity_scale = 0.535
	
	elif Game.score >= 45 and Game.score <= 100:		
		$ScrapTimer.wait_time = 0.215
		$ScrapTimer.start()
		scrap.gravity_scale = 0.675
		print($ScrapTimer.wait_time," : ",scrap.gravity_scale)
	add_child(scrap)
	
# GENERAR PUNTOS AL OBTENER MONEDAS
func _on_ScoreTimer_timeout():
	#if body.get_name("coin_tornillo")
	pass
		
# FUNCIÓN PRINCIPAL DE PRUEBAS 
func main():
	control()
	$Player.start($StartPosition.position)
	#$HUD.damage(Game.damage)	
	$MusicLevel.play()
	$ScrapTimer.start()	
	$CoinTimer.start()
		
# FUNCIÓN MAIN DE PRUEBAS 
func _ready():
	print($HUD.value_health())
	main()
