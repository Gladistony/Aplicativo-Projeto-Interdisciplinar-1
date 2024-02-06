extends Node2D

onready var label = $Status as Label

# Called when the node enters the scene tree for the first time.
func _ready():
	UsuarioData.connect("_readEnd",self, "finalLeituraUsuario")
	UsuarioData._loadData()

func _charceStade(newStade):
	label.text = newStade;

func finalLeituraUsuario():
	_charceStade("Carregando banco de dados ...")
