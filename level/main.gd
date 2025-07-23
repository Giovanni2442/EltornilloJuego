extends Node

@export var gameOver_scene: PackedScene
@export var description: String = "coin"
@export var Scrap_scene: PackedScene
 
#Conecta las señales del Singleton al metodo el juego al ser emitidas
func control():
	if not Game.new_game.is_connected(new_game):
		Game.new_game.connect(new_game)	#CONECTA CON LA FUNCIÓN 'new_Game()' SI LA SEÑAL FUE EMITIDA
	
# EMPEZAR NUEVO JUEGO
func new_game():
	#var scrap = Scrap_scene.instantiate()
	var gameOver = get_node_or_null("Screen_game_over")		# TOMAR EL NODO YA CREADO EN EL ARBOL DE ESCENAS
	
	if gameOver:						# VERIFICAR SI EXISTE EL NODO
		gameOver.queue_free()			# ELIMINAR LA PANTALLA DE GAME OVER
	else:
		print("No se pudo eliminar")
	Game.score = 0
	$HUD.update_score(0)		#RESETEAR EL PUNTAJE
	$HUD.restart_health()		#RESETEAR LA SALUD	
	$HUD.updateScoreRecord()	#ACTUALIZA EL RECORD GENERADO
	main()

# FINALIZAR JUEGO
func game_over(health):
	var gameOver = gameOver_scene.instantiate()		#ISTANCIA A LA PANTALLA GAME OVER
	gameOver.name = "Screen_game_over"				#AGREGAR ETIQUETA AL INSERTARSE AL ARBOL DE ESCENAS
	#print(health)
	if health == 17:
		#print("Se ejecuta!")
		$Player.hide()
		#$Player.queue_free()		
		$ScrapTimer.stop()	
		$MusicLevel.stop()		
		$CoinTimer.stop()			
		$HealthTimer.stop()
		#gameOver.record_update(Game.score)
		gameOver.record_update(Game.score)
		#gameOver.record(Game.score)				# !!FUNCIÓN DE PRUEBAS!!
		#$HUD.record_update(Game.score)			# ALMACENA LA NUEVA PUNTUACIÓN
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
			if $HUD.value_health() == 41:				
				Game.score += 5
			else : 
				$HUD.heal(8)					
		else : 
			Game.score += 1
		sound.play()
		$HUD.update_score(Game.score)
	else :
		sound.play()		
		Game.damage = 8
		$HUD.damage(Game.damage)	
		game_over($HUD.value_health())					
			
	body.visible = false
	await sound.finished
	body.queue_free()
		
# FUNCIÓN PRINCIPAL DE PRUEBAS 
func main():
	control()
	if $Player.is_inside_tree():		# VERIFICA SI EL NODO PLAYER ESTA DENTRO DEL ARBOL DE ESCENAS
		print(true)		
	else:
		print(false)
	$Player.start($StartPosition.position)
	#$HUD.damage(Game.damage)	
	$MusicLevel.play()
	$ScrapTimer.start()					# GENERAR CHATARRA(Enemigos)
	$CoinTimer.start()					# GENERAR MONEDAS
	$HealthTimer.start()				# GENERA MONEDAS DE SALUD
		
# FUNCIÓN MAIN DE PRUEBAS 
func _ready():
	#$MusicLevel.play()
	main()
