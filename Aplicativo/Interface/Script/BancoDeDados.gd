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
		print(dados["Z"].keys())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
