extends Node

const plugin_name = "extrasgladistony"
var plugin_singleton

var LimitesRemedio = 10
var LimiteHorarios = 5

var _ModoOff = true
var _ModoLogado = false
var _retornoPrincipal = false
var _carregamentoInicialCompleto = false
var _StartPesquisa = ""
var PesquisaNome = ""
var PesquisaTarja = ""
var PesquisaFabricante = ""
var PesquisaSubstancia = ""

func _LimparAdicicaoRemedio():
	PesquisaNome = ""
	PesquisaTarja = ""
	PesquisaFabricante = ""
	PesquisaSubstancia = ""

func _ready():
	if Engine.has_singleton(plugin_name):
		plugin_singleton = Engine.get_singleton(plugin_name)
	else:
		printerr("Falha ao inicializar o Plugin")
		
func print(Text: String):
	print(Text)
	if plugin_singleton:
		plugin_singleton.avisosPrint(Text)
	else:
		print("Initialization error")
