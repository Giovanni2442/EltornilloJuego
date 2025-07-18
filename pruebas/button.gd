extends Button

func _on_pressed() -> void:
	print("Btn de pruebas")
	get_tree().change_scene_to_file("res://level/main.tscn")
