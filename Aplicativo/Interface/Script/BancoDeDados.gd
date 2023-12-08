extends Node

var dados = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	if FileAccess.file_exists("res://Recursos/dados.json"):
		var arq = FileAccess.open("res://Recursos/dados.json",FileAccess.READ)
		var jsonstr =  arq.get_as_text()
		arq.close()
		var data = JSON.new()
		data.parse(jsonstr)
		dados = data.data
		#print(dados["Z"].keys())

func LetraInicial(string):
	var first_letter = string.left(1)
	return first_letter.to_upper()

func _buscaRemedio(nome):
	nome = nome.to_upper()
	var retorno = []
	var previa = dados.keys()
	for item in previa:
		if item.contains(nome):
			retorno.append(item)
	retorno.sort()
	return retorno

func _buscaSubstancia(nome):
	nome = nome.to_upper()
	var retorno = []
	var previa = dados.values()
	for item in previa:
		if item[0].substancia.contains(nome):
			retorno.append(item[0].produto)
	retorno.sort()
	return retorno 

func _dataRemedio(nome):
	if dados.has(nome):
		return dados[nome]
	else:
		return {}
	
