extends Node

var _dados = {}

signal _readEnd;

func _ready():
	pass # Replace with function body.

func _fileExist(name):
	var dir = Directory.new()
	return  dir.file_exists(name)

func _loadData():
	if _fileExist("res://Recursos/Banco de Dados/dados.json"):
		var file = File.new()
		#file.open("res://Recursos/Banco de Dados/dados.json", File.READ)
		#var jsonstr =  file.get_as_text()
	#	file.close()
		#var data = JSON.parse(jsonstr)
		var jf := JSONFile.new()
		jf.open("res://Recursos/Banco de Dados/dados.json", File.READ)
		var my_data = jf.load_data()
		print(my_data)
		#print(data.result)
		#data = data.result
		#JSON.print(jsonstr, "\t")
		#data.parse(jsonstr)
		#_dados = data.data
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
