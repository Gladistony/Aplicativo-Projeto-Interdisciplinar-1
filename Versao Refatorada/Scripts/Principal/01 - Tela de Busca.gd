extends Control

@onready var menuBaixo = get_node("Menu Abaixo")
@onready var boxBusca = get_node("Bloco de Pesquisa/Linha de Pesquisa") as LineEdit
@onready var listaResultados = get_node("Bloco de Resultados/Box de Scroll/Lista de Resultados")
@onready var preloadBox = preload("res://Recursos/Componentes/Box Auxiliar Medicamento.tscn")
@onready var JanelaPopUPInfo = get_node("Janela de POP Informacao Remedio")
@onready var BoxdeScroll = get_node("Bloco de Resultados/Box de Scroll")
@onready var label_medicamento = get_node("Bloco de Pesquisa/Label-Medicamento")
#============================================================
@onready var popNome = get_node("Janela de POP Informacao Remedio/Box de informacao Vertical/Nome/Label")
@onready var popSubstancia = get_node("Janela de POP Informacao Remedio/Box de informacao Vertical/Substancia/Label")
@onready var popFabricante = get_node("Janela de POP Informacao Remedio/Box de informacao Vertical/Fabricante/Label")
@onready var popDosagem = get_node("Janela de POP Informacao Remedio/Box de informacao Vertical/Apresentacao/Label")
@onready var popClasse = get_node("Janela de POP Informacao Remedio/Box de informacao Vertical/Classe/Label")
@onready var popTarja = get_node("Janela de POP Informacao Remedio/Box de informacao Vertical/Tarja/Label")
@onready var popTipo = get_node("Janela de POP Informacao Remedio/Box de informacao Vertical/Tipo/Label")
@onready var popPreco = get_node("Janela de POP Informacao Remedio/Box de informacao Vertical/Preco Estimado/Label")
#============================================================
var popIDFabricante = 0
var daraRemedioPop = {}
var buscarSubstancia = false #1 por nome 2 por substancia
var old_text = ""

func _ready():
	menuBaixo.connect("BotaoMenu",menuPrincipal)
	menuBaixo.connect("BotaoPerfil",_janelaPerfil)
	JanelaPopUPInfo.visible = false
	if VariaveisGlobais._StartPesquisa != "":
		boxBusca.text = VariaveisGlobais._StartPesquisa
		buscarMedSubs(boxBusca.text)
		VariaveisGlobais._StartPesquisa = ""
	#Abrir a janela automaticamente
	boxBusca.grab_focus()
func _janelaPerfil():
	get_tree().change_scene_to_file("res://Telas/Principal/02 - Perfil de Usuario.tscn")

func menuPrincipal():
	get_tree().change_scene_to_file("res://Telas/Principal/00 - Main.tscn")

func monstraPopUpInfo(nomeRemedio):
	JanelaPopUPInfo.move_to_center()
	JanelaPopUPInfo.visible = true
	popIDFabricante = 0
	daraRemedioPop = BancoDeDados._dataRemedio(nomeRemedio)
	#popNome.clear()
	#for fab in daraRemedioPop:
	#	popNome.add_item(fab.produto)
	attPopInfo()

func attPopInfo():
	popNome.text = daraRemedioPop[popIDFabricante].produto
	popSubstancia.text = daraRemedioPop[popIDFabricante].substancia
	popSubstancia.text = popSubstancia.text.replace(";","\n")
	popDosagem.text = daraRemedioPop[popIDFabricante].apresentacao
	popClasse.text = daraRemedioPop[popIDFabricante].classe.replace("/","\n")
	popTarja.text = daraRemedioPop[popIDFabricante].tarja.replace("Tarja ","")
	popTipo.text = daraRemedioPop[popIDFabricante].tipo
	popFabricante.text = daraRemedioPop[popIDFabricante].laboratorio
	popPreco.text = daraRemedioPop[popIDFabricante].estimativa
	if (len(popPreco.text) >= 9) or (len(popPreco.text) <= 1):
		popPreco.text = "Sem cadastro"
	else:
		popPreco.text = "R$ "+popPreco.text 
func clearBox():
	BoxdeScroll.scroll_vertical = 0
	for filhos in listaResultados.get_children():
		filhos.queue_free()

func addRemedio(nome):
	var caixa = preloadBox.instantiate()
	caixa._setNomeRemedio(nome)
	caixa.connect("abrirPop", monstraPopUpInfo)
	listaResultados.add_child(caixa)

func addSubstancia(nome):
	var caixa = preloadBox.instantiate()
	caixa._setNomeRemedio(nome)
	caixa.connect("abrirPop", monstraPopUpInfo)
	listaResultados.add_child(caixa)

func _on_janela_de_pop_informacao_remedio_close_requested():
	JanelaPopUPInfo.visible = false

func _on_option_button_item_selected(index):
	popIDFabricante = index
	attPopInfo()

func _on_botao_mudar_substancia_pressed():
	boxBusca.text = ""
	buscarSubstancia = not buscarSubstancia
	if buscarSubstancia:
		label_medicamento.text = "Substancia:"
	else:
		label_medicamento.text = "Medicamentos:"
	popIDFabricante = 0
	daraRemedioPop = {}
	clearBox()

func _on_botao_buscar_substancia_pressed():
	var subsTemp = daraRemedioPop[popIDFabricante].substancia
	if not buscarSubstancia:
		_on_botao_mudar_substancia_pressed()
	else:
		clearBox()
		popIDFabricante = 0
		daraRemedioPop = {}
	boxBusca.text = subsTemp
	buscarMedSubs(subsTemp)

func buscarMedSubs(new_text):
	JanelaPopUPInfo.visible = false
	if len(new_text) >= 2:
		clearBox()
		if not buscarSubstancia:
			for med in BancoDeDados._buscaRemedio(new_text):
				addRemedio(med)
		else:
			for med in BancoDeDados._buscaSubstancia(new_text):
				addSubstancia(med)
	else:
		clearBox()

func _on_auto_busca_timeout():
	if old_text != boxBusca.text:
		old_text = boxBusca.text
		buscarMedSubs(old_text)

func _on_linha_de_pesquisa_focus_entered():
	JanelaPopUPInfo.visible = false

func _input(event):
	#Fecha janela caso click fora dela
	if event is InputEventScreenTouch or event is InputEventMouseButton: # verifica se o evento é um toque na tela
		if event.pressed: # verifica se o toque foi iniciado
			var posClick = event.get_position()
			var posJanela = JanelaPopUPInfo.position
			var tamJanela = JanelaPopUPInfo.size
			var dentroX = (posClick.x >= posJanela.x) and (posClick.x <= (posJanela.x + tamJanela.x))
			var dentroY = (posClick.y >= posJanela.y) and (posClick.y <= (posJanela.y + tamJanela.y))
			if (not (dentroX and dentroY)):
				JanelaPopUPInfo.visible = false

func _on_fechar_pop_pressed():
	JanelaPopUPInfo.visible = false

func _on_novo_lembrete_pressed():
	if len(DadosCliente.medicamentos) < VariaveisGlobais.LimitesRemedio:
		VariaveisGlobais.PesquisaNome = popNome.text
		VariaveisGlobais.PesquisaSubstancia = popSubstancia.text
		VariaveisGlobais.PesquisaTarja =  popTarja.text
		VariaveisGlobais.PesquisaFabricante = popFabricante.text
		JanelaPopUPInfo.visible = false
		get_tree().change_scene_to_file("res://Telas/Principal/04 - Tela de Adicionar Remedio.tscn")
	else: 
		VariaveisGlobais.print('Limite de medicamentos atingido')
	
