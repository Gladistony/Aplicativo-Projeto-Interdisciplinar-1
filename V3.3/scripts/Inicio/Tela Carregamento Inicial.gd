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
	if NetWork.posTest:
		statusDoServidorDefinido()
	else:
		NetWork.connect("resposta", self, "statusDoServidorDefinido")
	#print(BancoDeDados._buscaRemedio("Dipirona"))

func statusDoServidorDefinido():
	print("Servidor definido")


func _on_Iniciar_timeout():
	UsuarioData._loadData()
