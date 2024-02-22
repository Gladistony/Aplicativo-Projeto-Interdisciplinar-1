extends Control

signal BotaoPesquisa
signal BotaoMenu
signal BotaoPerfil


func _on_button_busca_pressed():
	emit_signal("BotaoPesquisa")
	#$ButtonBusca.release_focus()


func _on_button_inicio_pressed():
	emit_signal("BotaoMenu")
	#$ButtonInicio.release_focus()


func _on_button_perfil_pressed():
	emit_signal("BotaoPerfil")
	#$ButtonPerfil.release_focus()
