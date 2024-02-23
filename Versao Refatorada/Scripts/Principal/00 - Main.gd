extends Control
#=======================
@onready var menuLateral = get_node("Menus/Menu Lateral")
@onready var menuBaixo = get_node("Menus/Menu Abaixo")
@onready var BoxdeScroll = get_node("Box de Scroll")
@onready var listaResultados = get_node("Box de Scroll/Lista de Resultados")
@onready var preloadBox = preload("res://Recursos/Componentes/Box Auxiliar Remedios Salvos.tscn")
#=======================
var recuar = false
var swipe_start = null # guarda a posição inicial do toque
var minimum_drag = 150 # define a distância mínima para considerar um swipe
var Swiper = 2000
#=======================
func _ready():
	menuLateral.connect("foraDaTela",_fecharMenu)
	menuLateral.connect("BotaoConfiguracao",_configuracao)
	menuLateral.connect("BotaoAdicionar",_adicionarLembrete)
	menuLateral.connect("BotaoRemedio",_pesquisaRemedio)
	menuBaixo.connect("BotaoPesquisa",_pesquisaRemedio)
	menuBaixo.connect("BotaoPerfil",_janelaPerfil)
	AtualizarListaRemedios()
	#=======================
	if not VariaveisGlobais._carregamentoInicialCompleto:
		VariaveisGlobais._carregamentoInicialCompleto = true
		if DadosCliente._estadoUsuario() and DadosCliente._eatadoLogado() and DadosCliente.registrado():
			if not VariaveisGlobais._ModoOff:
				var auth = Firebase.Auth.auth
				if auth.localid:
					var colllection: FirestoreCollection = Firebase.Firestore.collection("registros")
					var task: FirestoreTask = colllection.get_doc(auth.localid)
					var finished_task: FirestoreTask = await task.task_finished
					var documento = finished_task.document
					VariaveisGlobais._ModoLogado = true
					DadosCliente.saveColec = documento.doc_fields
					DadosCliente._data["backupData"] = documento.doc_fields
					DadosCliente._saveData()
			else:
				DadosCliente.saveColec = DadosCliente._data["backupData"]
#=======================
func AtualizarListaRemedios():
	
	clearBox()
	
	DadosCliente.processarMedicamentos()
	var cont = 0
	var nome = ""
	var horario = ""
	var data = "" 
	var agora = int(Time.get_unix_time_from_system())
	#precisa fazer a função que pega só os prox 3 remédios 
	#for medicamento in DadosCliente.medicamentos:
		#cont += 1
		#nome = medicamento["remedio"]
		#preloadBox._setNomeRemedio(nome)
		#horario = str(medicamento["Horarios"][0]["hora"])+" : "+str(medicamento["Horarios"][0]["min"])
		#preloadBox._setHorarioRemedio(horario)
		#listaResultados.add_child(preloadBox.instantiate())

func clearBox():
	if listaResultados != null:
		BoxdeScroll.scroll_vertical = 0
		for filhos in listaResultados.get_children():
			filhos.queue_free()
	else:
		return		

func _janelaPerfil():
	get_tree().change_scene_to_file("res://Telas/Principal/02 - Perfil de Usuario.tscn")
func _pesquisaRemedio():
	recuar = true
	get_tree().change_scene_to_file("res://Telas/Principal/01 - Tela de Busca.tscn")
func _adicionarLembrete():
	recuar = true
	if len(DadosCliente.medicamentos) < VariaveisGlobais.LimitesRemedio:
		VariaveisGlobais._LimparAdicicaoRemedio()
		get_tree().change_scene_to_file("res://Telas/Principal/04 - Tela de Adicionar Remedio.tscn")
	else: 
		VariaveisGlobais.print('Limite de medicamentos atingido')
func _configuracao():
	recuar = true
	VariaveisGlobais._retornoPrincipal = true
	get_tree().change_scene_to_file("res://Telas/Principal/03 - Tela de Configuracao.tscn")
func _fecharMenu():
	recuar = true
#=======================
func _calculate_swipe(swipe_end):
	if swipe_start == null: return # se não houve toque inicial, retorna
	var swipe = swipe_end - swipe_start # calcula o vetor do swipe
	if abs(swipe.x) > minimum_drag: #and swipe_start.x < margin: # verifica se o swipe foi suficiente e se começou no canto esquerdo
		if swipe.x > 0: # verifica se o swipe foi da esquerda para a direita
			_on_botao_menu_lateral_pressed() # chama a função que você quer executar quando o swipe acontecer
		elif  swipe.x < 0:
			_fecharMenu()
#=======================
func _process(delta):
	#$"Lista de Medicamentos".visible = not menuLateral.visible
	if menuLateral.visible and menuLateral.position.x < 0 and not recuar:
		menuLateral.position.x += delta*1500
		menuLateral.position.x += delta*Swiper
	if menuLateral.position.x > 0:
		menuLateral.position.x = 0
	if recuar:
		menuLateral.position.x -= delta*1500
		menuLateral.position.x -= delta*Swiper
		if menuLateral.position.x <= -512:
			recuar = false
			menuLateral.position.x = -512
			menuLateral.visible = false
func _input(event):
	if event is InputEventScreenTouch: # verifica se o evento é um toque na tela
		if event.pressed: # verifica se o toque foi iniciado
			swipe_start = event.get_position() # guarda a posição inicial do toque
		else: # verifica se o toque foi finalizado
			_calculate_swipe(event.get_position()) # calcula se houve um swipe
func _on_botao_menu_lateral_pressed():
	menuLateral.visible = true


func _on_botao_fundo_azul_pressed():
	get_tree().change_scene_to_file("res://Telas/Principal/04 - Tela de Adicionar Remedio.tscn")
