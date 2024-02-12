extends Control

var nomeaq = ""

func _ready():
	pass

func _process(delta):
	$VBoxContainer/LabelNome.text = DadosCliente._nomeMedicamento
	$VBoxContainer/VBoxInformacoes/LabelSubstancia.text = DadosCliente._substanciaMedicamento
	$VBoxContainer/VBoxInformacoes/LabelFabricante.text = DadosCliente._fabricanteMedicamento

func _on_botao_adicionar_pressed():
	get_tree().change_scene_to_file("res://Tela/tela_principal.tscn")
