extends LineEdit

func contentInput():
	print(text)
	
func _ready():
	contentInput()
