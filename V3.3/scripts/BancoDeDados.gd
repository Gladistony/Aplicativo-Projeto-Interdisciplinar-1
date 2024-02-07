extends Node

var _dados = {}

signal _readEnd;

func _ready():
	pass # Replace with function body.

func _fileExist(name):
	var dir = Directory.new()
	return  dir.file_exists(name)

func _loadData():
	if _fileExist("res://Recursos/Banco de Dados/data.dat"):
		var file = File.new()
		file.open("res://Recursos/Banco de Dados/data.dat", File.READ)
		while !file.eof_reached():
			var data = file.get_line()
			data = data.split("@")
			var produto = {}
			var nome = "desconhecido"
			for i in range(data.size()):
				var lendo = data[i].split("!")
				if len(lendo) == 2:
					produto[lendo[0]] = lendo[1]
			if produto.has("produto"):
				nome = produto["produto"]
			#var produto = {"produto":nome, "substancia":substancia, "laboratorio":laboratorio, "apresentacao":apresentacao, "preco":preco, "tarja":tarja, "tipo":tipo, "classe":classe, "registro":registro, "ean":ean}
			if _dados.has(nome):
				_dados[nome].append(produto)
			else:
				_dados[nome] = [produto]
		file.close()
		#print(_dados)

	emit_signal("_readEnd")

func LetraInicial(string):
	var first_letter = string.left(1)
	return first_letter.to_upper()

func _buscaRemedio(nome):
	nome = nome.to_upper()
	var retorno = []
	var retorno2 = []
	var previa = _dados.keys()
	for item in previa:
		var pos = item.find(nome)
		if pos == 0:
			retorno.append(item)
		elif pos > 0:
			retorno2.append(item)
	retorno.sort()
	retorno2.sort()
	return retorno+retorno2

func _buscaSubstancia(nome):
	nome = nome.to_upper()
	var retorno = []
	var previa = _dados.values()
	for item in previa:
		if item[0].substancia.contains(nome):
			retorno.append(item[0].produto)
	retorno.sort()
	return retorno 

func _dataRemedio(nome):
	if _dados.has(nome):
		return _dados[nome]
	else:
		return {}
