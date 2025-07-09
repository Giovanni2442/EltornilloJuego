extends RigidBody2D
var typeAnimation

@export var descripcion = "Coin"

func _ready():
	# ARREGLO DE COINS
	var coin_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	typeAnimation = coin_types.pick_random()	
	$AnimatedSprite2D.animation = typeAnimation			#SELECCIÓNA EL NOMBRE EL SPRITE DE MANERA ALEATORIA
	$AnimatedSprite2D
	$AnimatedSprite2D.play()

# AL SALIR LOS ITEMS DE LA PANTALLA, SE ELIMINAN
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
