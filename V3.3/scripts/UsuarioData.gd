extends Node


var login = ""
var senha = ""
var token = ""
var loginStatus = false

signal _readEnd;

func _fileExist(name):
	var dir = Directory.new()
	return  dir.file_exists(name)


func _logOff():
	login = ""
	senha = ""
	token = ""
	loginStatus = false
	_saveData()

func _ready():
	pass

func _loadData():
	if _fileExist("res://dadosLocais.datLife"):
		var file = File.new()
		file.open("res://dadosLocais.datLife", File.READ)
		login = file.get_line()
		senha = file.get_line()
		token = file.get_line()
		loginStatus = bool(file.get_line())
		file.close()
		
	emit_signal("_readEnd")

func _saveData():
	var file = File.new()
	file.open("res://dadosLocais.datLife", File.WRITE)
	file.store_string(login)
	file.store_string(senha)
	file.store_string(token)
	file.store_string(str(loginStatus))
	file.close()
