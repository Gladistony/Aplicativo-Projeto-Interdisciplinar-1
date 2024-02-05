extends Control

@onready var menuBaixo = get_node("MenuH")
@onready var nomeLabel = get_node("Label-Login")

# Called when the node enters the scene tree for the first time.
func _ready():
	menuBaixo.connect("BotaoMenu",menuPrincipal)
	menuBaixo.connect("BotaoPesquisa",_pesquisaRemedio)
	if DadosCliente._data.has("nome"):
		nomeLabel.text = DadosCliente._data.nome
	

func _pesquisaRemedio():
	get_tree().change_scene_to_file("res://Tela/Tela_Pesquisa.tscn")

func menuPrincipal():
	get_tree().change_scene_to_file("res://Tela/tela_principal.tscn")


func _on_botão_voltar_pressed():
	get_tree().change_scene_to_file("res://Tela/tela_principal.tscn")


func _on_botao_config_pressed():
	get_tree().change_scene_to_file("res://Tela/Tela_Configuracoes.tscn")
	
