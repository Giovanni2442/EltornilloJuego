extends Node

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
	add_child($Player)
	main()

# FINALIZAR JUEGO
func game_over(health):
	var gameOver = gameOver_scene.instantiate()		#ISTANCIA A LA PANTALLA GAME OVER
	gameOver.name = "Screen_game_over"				#AGREGAR ETIQUETA LA INSERTARSE AL ARBOL DE ESCENAS
	#print(health)
	if health == 25:
		print("Se ejecuta!")
		$Player.hide()
		#$Player.queue_free()
		$MusicLevel.stop()
		$ScrapTimer.stop()	
		$CoinTimer.stop()
		$HealthTimer.stop()
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
		if sprite.animation == "especial":
			Game.score += 10	
		elif sprite.animation == "health" :
			$HUD.heal(25)		
		else : 
			Game.score += 1
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
	
		
# FUNCIÓN PRINCIPAL DE PRUEBAS 
func main():
	control()
	$Player.start($StartPosition.position)
	#$HUD.damage(Game.damage)	
	$MusicLevel.play()
	$ScrapTimer.start()					# GENERAR CHATARRA(Enemigos)
	$CoinTimer.start()					# GENERAR MONEDAS
	$HealthTimer.start()				# GENERA MONEDAS DE SALUD
		
# FUNCIÓN MAIN DE PRUEBAS 
func _ready():
	main()
