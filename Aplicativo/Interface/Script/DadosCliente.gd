extends Node

var _modoOffLine = true #Variavel que marca se o usuario está online ou não
var _logado = false #variavel que guarda se o usuario está com dados logados
var _autoLogin = false #Se torna verdade quando o usuario escolhe uma opção de login
var _data = {} #Armazena os dados do usuario
var _retornoPrincipal = false #Função usada pra controlar o retorno a tela principal com o botão voltar


func receberLastLogin(email,senha):
	_data.email = email
	_data.senha = senha

func receberInfo(nome, data, foto):
	_data.nome = nome
	_data.nascimento = data
	_data.foto = foto

func _loginAutoOffLine():
	_modoOffLine = true
	_logado = false

# Called when the node enters the scene tree for the first time.
func _ready():
	_loadData()
	_autoLogin = _data.has("nome")
	if not _data.has("remediosAgendados"):
		_data.remediosAgendados = []

func _loadData():
	if FileAccess.file_exists("res://dadosLocais.datLife"):
		var arq = FileAccess.open("res://dadosLocais.datLife",FileAccess.READ)
		var jsonstr =  arq.get_as_text()
		arq.close()
		var data = JSON.new()
		data.parse(jsonstr)
		_data = data.data

func _saveData():
	var file = FileAccess.open("res://dadosLocais.datLife", FileAccess.WRITE)
	file.store_line(JSON.stringify(_data))
	file.close()
