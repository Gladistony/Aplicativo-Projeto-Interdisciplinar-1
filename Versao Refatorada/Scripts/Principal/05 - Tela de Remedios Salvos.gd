extends Control

@onready var menuBaixo = get_node("Menu Abaixo")
@onready var BoxdeScroll = get_node("Box de Scroll")
@onready var BoxdeScroll2 = get_node("Box de Scroll 2")
@onready var listaResultados = get_node("Box de Scroll/Lista de Resultados")
@onready var preloadBox = preload("res://Recursos/Componentes/Box Auxiliar Remedios Salvos.tscn")
@onready var listaAntigos = get_node("Box de Scroll 2/Lista de Antigos")
@onready var preloadBox2 = preload("res://Recursos/Componentes/Box Auxiliar Remedios Antigos.tscn")

var dataRemedio = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	menuBaixo.connect("BotaoMenu",menuPrincipal)
	menuBaixo.connect("BotaoPerfil",_janelaPerfil)
	menuBaixo.connect("BotaoPesquisa", botaopesquisa)
	AtualizarListaRemedios()
	
func AtualizarListaRemedios():
	
	clearBox()
	
	DadosCliente.processarMedicamentos()
	var cont = 0
	var nome = ""
	var horario = ""
	var data = "" 
	var agora = int(Time.get_unix_time_from_system())
	
	for medicamento in DadosCliente.medicamentos:
		cont += 1
		nome = medicamento["remedio"]
		preloadBox._setNomeRemedio(nome)
		horario = str(medicamento["Horarios"][0]["hora"])+" : "+str(medicamento["Horarios"][0]["min"])
		preloadBox._setHorarioRemedio(horario)
		listaResultados.add_child(preloadBox.instantiate())
		
	for medicamentoAntigo in DadosCliente.medicamentos:
		cont += 1
		if medicamentoAntigo["data"] < agora:
			nome = medicamentoAntigo["remedio"]
			preloadBox2._setNomeRemedio(nome)
			horario = str(medicamentoAntigo["Horarios"][0]["hora"])+" : "+str(medicamentoAntigo["Horarios"][0]["min"])
			preloadBox2._setHorarioRemedio(horario)
			data = medicamentoAntigo["data"]
			preloadBox2._setDataRemedio(data)
			listaAntigos.add_child(preloadBox.instantiate())

func _janelaPerfil():
	get_tree().change_scene_to_file("res://Telas/Principal/02 - Perfil de Usuario.tscn")

func menuPrincipal():
	get_tree().change_scene_to_file("res://Telas/Principal/00 - Main.tscn")

func botaopesquisa():
	get_tree().change_scene_to_file("res://Telas/Principal/01 - Tela de Busca.tscn")

func clearBox():
	if listaResultados != null and listaAntigos != null:
		BoxdeScroll.scroll_vertical = 0
		BoxdeScroll2.scroll_vertical = 0
		for filhos in listaResultados.get_children():
			filhos.queue_free()
		for filhos in listaAntigos.get_children():
			filhos.queue_free()
	else:
		return
	
func _on_voltar_pressed():
	get_tree().change_scene_to_file("res://Telas/Principal/02 - Perfil de Usuario.tscn")


func _on_adicionar_mais_pressed():
	get_tree().change_scene_to_file("res://Telas/Principal/04 - Tela de Adicionar Remedio.tscn")
