extends Node2D

func _ready():
	if not NetWork._servidorLigado:
		$BotaoLogin.visible = false
		$BotaoRegistro.visible = false

func _on_BotaoRegistro_pressed():
	get_tree().change_scene("res://Telas/Inicio/Tela Cadastro.tscn")
