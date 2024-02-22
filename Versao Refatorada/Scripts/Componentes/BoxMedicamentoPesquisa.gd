extends Control

signal abrirPop(nome);

func _setNomeRemedio(nome):
	$NomeRemedio.text = nome


func _on_botao_info_remedio_pressed():
	emit_signal("abrirPop", $NomeRemedio.text)
