extends Area2D

signal catch(body)			# Atrapar objeto
@export var speed = 400
var screen_size									#TAMAÑO DE LA PANTALLA DEL JUEGO

# --- MOVILIDAD DEL JUGADOR --- 
func movPlayer(delta):
	var velocity = Vector2.ZERO					#VECTOR EN EL ESPACIO 2D
	if Input.is_action_pressed("walk_left"):
		velocity.x -= 1
	if Input.is_action_pressed("walk_right"):
		velocity.x += 1
	
	# ACTIVAR ANIMACIÓN
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.play()
	
	# ACTIVA LA ANIMACIÓN, DEPENDIENDO DEL VALOR EN EL VECTOR 2D	
	if velocity.x == 0 :		
		$AnimatedSprite2D.animation = "Iddle"
	elif velocity.x > 0 :
		$AnimatedSprite2D.animation = "walk_right" 
	elif velocity.x < 0 :
		$AnimatedSprite2D.animation = "walk_left"
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO,screen_size)

# COLOCAR AL JUGADOR EN EL JUEGO
func start(pos):
	position = pos		# COLOCA EN UNA POSICIÓN DADA AL JUGADOR
	rotation = 0
	show()
	
# CAPTURAR ELEMENTOS	
func _on_body_entered(body):
	emit_signal("catch",body)
		
# --- INVOCADOR DE SEÑALES Y ELEMENTOS ---
func _ready():
	screen_size = get_viewport_rect().size		#INVOCA EL TAMAÑO DE LA PANTALLA ESTABLECIDA
		
# --- CICLO FOTOGRAMAS DEL JUEGO --- 
func _process(delta):
	movPlayer(delta)
