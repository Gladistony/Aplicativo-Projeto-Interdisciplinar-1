extends Node

var _data = {}
signal _readEnd;

func _fileExist(name):
	var dir = Directory.new()
	return  dir.file_exists(name)


func _logOff():
	_data.login = ""
	_data.senha = ""
	_data.token = true
	_data.loginStatus = false

func _ready():
	_data.login = ""
	_data.senha = ""
	_data.token = true
	_data.loginStatus = false

func _loadData():
	if _fileExist("res://dadosLocais.datLife"):
		var file = File.new()
		file.open("res://dadosLocais.datLife", File.READ)
		#var arq = FileAccess.open("",FileAccess.READ)
		var jsonstr =  file.get_as_text()
		file.close()
		var data = JSON.new()
		data.parse(jsonstr)
		_data = data.data
	emit_signal("_readEnd")

func _saveData():
	var file = File.new()
	file.open("res://dadosLocais.datLife", File.WRITE)
	file.store_line(JSON.stringify(_data))
	file.close()
