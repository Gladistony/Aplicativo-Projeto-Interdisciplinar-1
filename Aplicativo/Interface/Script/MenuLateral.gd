extends Control

signal  foraDaTela;
signal BotaoRemedio;
signal BotaoConfiguracao;
signal BotaoAdicionar;


func _on_botão_remedios_pressed():
	emit_signal("BotaoRemedio")


func _on_botão_configuracao_pressed():
	emit_signal("BotaoConfiguracao")


func _on_botão_adicionar_pressed():
	emit_signal("BotaoAdicionar")

func _on_area_vazia_pressed():
	emit_signal("foraDaTela")
	#$AreaVazia.release_focus()
