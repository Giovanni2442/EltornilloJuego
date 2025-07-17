extends RigidBody2D

@export var descripcion = "Scrap"

# AL SALIR LOS ITEMS DE LA PANTALLA, SE ELIMINAN
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
