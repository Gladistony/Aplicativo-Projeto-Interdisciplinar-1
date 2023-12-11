extends Control

@onready var menuBaixo = get_node("MenuH")

# Called when the node enters the scene tree for the first time.
func _ready():
	menuBaixo.connect("BotaoMenu",menuPrincipal)
	menuBaixo.connect("BotaoPesquisa",_pesquisaRemedio)

func _pesquisaRemedio():
	get_tree().change_scene_to_file("res://Tela/Tela_Pesquisa.tscn")

func menuPrincipal():
	get_tree().change_scene_to_file("res://Tela/tela_principal.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_botão_voltar_pressed():
	get_tree().change_scene_to_file("res://Tela/tela_principal.tscn")


func _on_botao_config_pressed():
	get_tree().change_scene_to_file("res://Tela/Tela_Configuracoes.tscn")
	
