extends Node2D

@onready var input = $LineEdit

func _on_button_pressed():
	print("--> : ",input.text)
