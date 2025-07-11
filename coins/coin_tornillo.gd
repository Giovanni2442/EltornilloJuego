extends RigidBody2D
var typeAnimation

@export var descripcion = "Coin"

func _ready():
	# ARREGLO DE COINS
	#print(coin_types[1])
	#random_coin()
	pass
	
#generate a random coin element
func random_coin():
	var coin_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	coin_types.erase("health")
	#print(coin_types)
	typeAnimation = coin_types.pick_random()	
	$AnimatedSprite2D.animation = typeAnimation			#SELECCIÓNA EL NOMBRE EL SPRITE DE MANERA ALEATORIA
	$AnimatedSprite2D.play()
	
#generate health coin 
func coin_health():
	var health = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = health[1]
	$AnimatedSprite2D.play()

# AL SALIR LOS ITEMS DE LA PANTALLA, SE ELIMINAN
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
