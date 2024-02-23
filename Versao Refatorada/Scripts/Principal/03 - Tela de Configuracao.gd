extends Control

@onready var menuBaixo = get_node("Menu Abaixo")

# Called when the node enters the scene tree for the first time.
func _ready():
	menuBaixo.connect("BotaoMenu",menuPrincipal)
	menuBaixo.connect("BotaoPerfil",_janelaPerfil)
	menuBaixo.connect("BotaoPesquisa", botaopesquisa)
	AtualizarListaRemedios()

func _janelaPerfil():
	get_tree().change_scene_to_file("res://Telas/Principal/02 - Perfil de Usuario.tscn")

func menuPrincipal():
	get_tree().change_scene_to_file("res://Telas/Principal/00 - Main.tscn")

func botaopesquisa():
	get_tree().change_scene_to_file("res://Telas/Principal/01 - Tela de Busca.tscn")

func AtualizarListaRemedios():
	DadosCliente.processarMedicamentos()
	$"Lista de Medicamentos".text = ""
	$"Lista de Medicamentos".visible = false
	var cont = 0
	for medicamento in DadosCliente.medicamentos:
		$"Lista de Medicamentos".visible = true
		cont += 1
		$"Lista de Medicamentos".text += str(cont) + " - "+ medicamento["remedio"]+" - Hora:"+str(medicamento["Horarios"][0]["hora"])+" : "+str(medicamento["Horarios"][0]["min"])+"\n"
