extends Control

@onready var menuBaixo = get_node("Menu Abaixo")
@onready var BoxdeScroll = get_node("Box de Scroll")
@onready var listaResultados = get_node("Lista de Resultados")
@onready var preloadBox = preload("res://Recursos/Componentes/Box Auxiliar Remedios Salvos.tscn")

var dataRemedio = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	menuBaixo.connect("BotaoMenu",menuPrincipal)
	menuBaixo.connect("BotaoPerfil",_janelaPerfil)
	menuBaixo.connect("BotaoPesquisa", botaopesquisa)

func _janelaPerfil():
	get_tree().change_scene_to_file("res://Telas/Principal/02 - Perfil de Usuario.tscn")

func menuPrincipal():
	get_tree().change_scene_to_file("res://Telas/Principal/00 - Main.tscn")

func botaopesquisa():
	get_tree().change_scene_to_file("res://Telas/Principal/01 - Tela de Busca.tscn")

func clearBox():
	BoxdeScroll.scroll_vertical = 0
	for filhos in listaResultados.get_children():
		filhos.queue_free()
		
func monstraInfo(nomeRemedio):
	dataRemedio = BancoDeDados._dataRemedio(nomeRemedio)

func addRemedio(nome,hora):
	var caixa = preloadBox.instantiate()
	caixa._setNomeRemedio(nome)
	caixa._setHoraRemedio(hora)
	listaResultados.add_child(caixa)
func _on_voltar_pressed():
	get_tree().change_scene_to_file("res://Telas/Principal/02 - Perfil de Usuario.tscn")


func _on_adicionar_mais_pressed():
	get_tree().change_scene_to_file("res://Telas/Principal/04 - Tela de Adicionar Remedio.tscn")
