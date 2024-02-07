extends Node2D

onready var label = $Status as Label
var thread = Thread.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	UsuarioData.connect("_readEnd",self, "finalLeituraUsuario")
	BancoDeDados.connect("_readEnd", self, "finalLeituraBanco")
	

func _charceStade(newStade):
	label.text = newStade;

func finalLeituraUsuario():
	_charceStade("Carregando banco de dados ...")
	BancoDeDados._loadData()
	

func loadBancoDeDados():
	BancoDeDados._loadData()

func finalLeituraBanco():
	_charceStade("Tentando conectar ao servidor ...")
	$EsgotadoResposta.start()
	if NetWork.posTest:
		statusDoServidorDefinido()
	else:
		NetWork.connect("resposta", self, "statusDoServidorDefinido")
	#print(BancoDeDados._buscaRemedio("Dipirona"))

func statusDoServidorDefinido():
	print("Servidor definido ", NetWork._servidorLigado)
	if not UsuarioData.loginStatus:
		get_tree().change_scene("res://Telas/Inicio/Tela Entrada.tscn")


func _on_Iniciar_timeout():
	UsuarioData._loadData()


func _on_EsgotadoResposta_timeout():
	if not NetWork._servidorLigado:
		NetWork.posTest = true
		NetWork._servidorLigado = false
		statusDoServidorDefinido()
