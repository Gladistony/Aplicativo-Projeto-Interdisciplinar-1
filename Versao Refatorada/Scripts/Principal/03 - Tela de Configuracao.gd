extends Control

@onready var menuBaixo = get_node("Menu Abaixo")

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

func _on_voltar_pressed():
	get_tree().change_scene_to_file("res://Telas/Principal/02 - Perfil de Usuario.tscn")

func _on_alterar_pressed():
	get_tree().change_scene_to_file("res://Telas/Principal/06 - Tela de Redefinir Dados.tscn")
