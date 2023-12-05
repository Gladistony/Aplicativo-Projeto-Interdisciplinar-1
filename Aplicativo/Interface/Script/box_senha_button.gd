extends Sprite2D

var olho_aberto = preload("res://Recursos/Box/open_eye.png")
var olho_fechado = preload("res://Recursos/Box/closed_eye.png")


func _on_visibilidade_pressed():
	$Usuario.secret = not $Usuario.secret
	if $Usuario.secret:
		$Olho.texture = olho_aberto
	else:
		$Olho.texture = olho_fechado
