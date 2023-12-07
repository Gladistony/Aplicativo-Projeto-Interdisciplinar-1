extends Node

var _modoOffLine = true
var _logado = false
var _data = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	_data.remediosAgendados = []
	_loadData()


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
