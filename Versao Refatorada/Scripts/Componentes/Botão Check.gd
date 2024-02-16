extends Control

var checked = preload("res://Recursos/Imagens/Imagens Box/checkbox-checked.png")
var uncheked = preload("res://Recursos/Imagens/Imagens Box/checkbox-unchecked.png")
var _check = false

func _ready(): 
	_check = false

func _on_button_check_pressed():
	_check = not _check
	if _check :
		$ButtonCheck.texture_normal = checked
	else:
		$ButtonCheck.texture_normal = uncheked
