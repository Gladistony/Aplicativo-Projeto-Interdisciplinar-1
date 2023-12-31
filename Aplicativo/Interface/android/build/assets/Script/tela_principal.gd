extends Control

@onready var menuLateral = get_node("MenuLateral")
@onready var menuBaixo = get_node("MenuH")

var recuar = false
#=======================
var swipe_start = null # guarda a posição inicial do toque
var minimum_drag = 100 # define a distância mínima para considerar um swipe
var Swiper = 2000
#var margin = 0 # define a margem para iniciar o swipe no canto esquerdo
#=======================

# Called when the node enters the scene tree for the first time.
func _ready():
	menuLateral.connect("foraDaTela",_fecharMenu)
	menuLateral.connect("BotaoConfiguracao",_configuracao)
	menuLateral.connect("BotaoAdicionar",_adicionarLembrete)
	menuLateral.connect("BotaoRemedio",_pesquisaRemedio)
	menuBaixo.connect("BotaoPesquisa",_pesquisaRemedio)
	menuBaixo.connect("BotaoPerfil",_janelaPerfil)
	
	if len(DadosCliente._data.remediosAgendados) == 0:
		_SemItemCadastrado()

func _janelaPerfil():
	get_tree().change_scene_to_file("res://Tela/Tela_Perfil.tscn")
	
func _pesquisaRemedio():
	recuar = true
	get_tree().change_scene_to_file("res://Tela/Tela_Pesquisa.tscn")

func _adicionarLembrete():
	recuar = true

func _configuracao():
	recuar = true
	DadosCliente._retornoPrincipal = true
	get_tree().change_scene_to_file("res://Tela/Tela_Configuracoes.tscn")

func _fecharMenu():
	recuar = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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


func _on_botão_menu_lateral_pressed():
	menuLateral.visible = true

func _unhandled_input(event):
	if event is InputEventScreenTouch: # verifica se o evento é um toque na tela
		if event.pressed: # verifica se o toque foi iniciado
			swipe_start = event.get_position() # guarda a posição inicial do toque
		else: # verifica se o toque foi finalizado
			_calculate_swipe(event.get_position()) # calcula se houve um swipe
func _calculate_swipe(swipe_end):
	if swipe_start == null: return # se não houve toque inicial, retorna
	var swipe = swipe_end - swipe_start # calcula o vetor do swipe
	if abs(swipe.x) > minimum_drag: #and swipe_start.x < margin: # verifica se o swipe foi suficiente e se começou no canto esquerdo
		if swipe.x > 0: # verifica se o swipe foi da esquerda para a direita
			_on_botão_menu_lateral_pressed() # chama a função que você quer executar quando o swipe acontecer
		elif  swipe.x < 0:
			_fecharMenu()

func _SemItemCadastrado():
	$MenuProximoRemedio.visible = false
	$AdicionarEAgenda.position.y = 620 #else: 1408
