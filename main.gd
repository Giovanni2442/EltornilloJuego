extends Node
@export var coins_scene: PackedScene
@export var scrap_scene: PackedScene

@export var description: String = "coin"

var score = 0
var health = 0

# COLICIONA CON OBJETO
func catch_object(body):
	var nameObject = body.descripcion
	var sprite = body.get_node("AnimatedSprite2D")
	var sound = body.get_node("AudioStreamPlayer2D")
		
	if nameObject == "Coin":
		if sprite.animation != "especial":
			score += 1			
		else : 
			score += 10
		sound.play()
		$HUD.update_score(score)
	else :
		sound.play()		
		health = 33.3
		$HUD.damage(health)						
			
	body.visible = false
	await sound.finished
	body.queue_free()
	
#			 --- TEMPORIZADORES --- 
# GENERAR MONEDAS
func _on_Coin_timer_timeout():
	var coin = coins_scene.instantiate()
	# X : NUMERO ALEATORIO 0-399 , Y : -50(por encima de la pantalla)
	coin.position = Vector2(randi() % 400, -50) 	# randi()	: Genera un numero entero largo
	add_child(coin)
	
# GENERAR CHATARRA(Enemigos)
func _on_ScrapTimer_timeout():
	var scrap = scrap_scene.instantiate()
	scrap.position = Vector2(randi() % 500, -50)
	add_child(scrap)
	
# GENERAR PUNTOS AL OBTENER MONEDAS
func _on_ScoreTimer_timeout():
	#if body.get_name("coin_tornillo")
	pass
		
# FUNCIÓN PRINCIPAL DE PRUEBAS 
func main():
	$Player.start($StartPosition.position)
	$AudioStreamPlayer2D.play()
	$ScrapTimer.start()	
	$CoinTimer.start()
		
# FUNCIÓN MAIN DE PRUEBAS 
func _ready():
	main()
