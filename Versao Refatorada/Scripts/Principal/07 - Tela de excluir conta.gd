extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_voltar_pressed():
	get_tree().change_scene_to_file("res://Telas/Principal/03 - Tela de Configuracao.tscn")


func _on_botao_fundo_azul_pressed():
	get_tree().change_scene_to_file("res://Telas/Principal/00 - Main.tscn")


func _on_botao_fundo_azul_2_pressed():
	DadosCliente.deletarConta()
