extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_voltar_pressed():
	get_tree().change_scene_to_file("res://Telas/Principal/03 - Tela de Configuracao.tscn")

func _on_cancelar_pressed():
	get_tree().change_scene_to_file("res://Telas/Principal/00 - Main.tscn")

func _on_deletar_pressed():
	#colocar código aqui
	DadosCliente.deletarConta()
