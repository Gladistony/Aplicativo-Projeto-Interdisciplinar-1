extends LineEdit

var olho_aberto = preload("res://Recursos/Imagens/Imagens Box/open_eye.png")
var olho_fechado = preload("res://Recursos/Imagens/Imagens Box/closed_eye.png")
@onready var ImagemOlho = $Olho as Sprite2D
@onready var Box = $"." as LineEdit


func _on_button_pressed():
	Box.secret = not Box.secret
	if Box.secret:
		ImagemOlho.texture = olho_aberto
	else:
		ImagemOlho.texture = olho_fechado




func _on_renomear_pressed():
	Box.editable  = true
