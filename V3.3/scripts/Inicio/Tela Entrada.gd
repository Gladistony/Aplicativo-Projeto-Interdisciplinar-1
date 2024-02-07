extends Node2D

func _ready():
	if not NetWork._servidorLigado:
		$BotaoLogin.visible = false
		$BotaoRegistro.visible = false


