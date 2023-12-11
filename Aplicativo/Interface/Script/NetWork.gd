extends Node

signal _respostaRecebida

var http_request = HTTPRequest.new()
var servidor = "https://deploy-api-pgp.onrender.com"
var _servidorOnline = false
var _esperando = false
var _lastRespost #ultima resposta recebida pelo servidor
var posTest = false #depois de verificar se o servidor já foi testado pra login
var Stado = 0 #Estado 0, não logado estado 1 logado
var _tokenLogin = ""

func processEstado():
	if Stado == 0:
		if _lastRespost is Dictionary and _lastRespost.has("token"):
			Stado = 1
			_tokenLogin = _lastRespost.token
			get_tree().change_scene_to_file("res://Tela/tela_principal.tscn")
			print(_lastRespost)
			var body = JSON.stringify({"token": _tokenLogin})
			var toke = "Authorization: Bearer "+_tokenLogin
			var error = http_request.request(servidor+"/cadastro/1", ["Content-Type: application/json", toke], HTTPClient.METHOD_GET , "{}")
	elif Stado == 1:
		print("teste ",_lastRespost)

func _tryLogin(email,senha):
	if _servidorOnline and not _esperando:
		var body = JSON.stringify({"login": email, "senha":senha})
		var error = http_request.request(servidor+"/login", ["Content-Type: application/json"], HTTPClient.METHOD_POST , body)
		_esperando = true
		if error != OK:
			_servidorOnline = false
			_esperando = false

func _ready():
	#Criar um network e adicionar ele como filho nesse nó 
	add_child(http_request)
	http_request.connect("request_completed", _request_completed)
	var body = JSON.stringify({"login": "teste@teste.com", "senha":"123"})
	#var error = http_request.request("https://httpbin.org/post", [], HTTPClient.METHOD_POST, body)
	var error = http_request.request(servidor+"/login", ["Content-Type: application/json"], HTTPClient.METHOD_POST , body)
	_esperando = true
	if error != OK:
		_servidorOnline = false
		_esperando = false
		#push_error("An error occurred in the HTTP request.")

func converter_ASCIIToString(lista):
	var new_string = ""
	for code in lista:
		var charString = String.chr(code)
		new_string += charString
	return new_string
	
func _request_completed(_result, _response_code, _headers, body):
	var response = converter_ASCIIToString(body)
	print(_response_code, response)
	_esperando = false
	if not posTest:
		if (response == null) or (response.contains("suspend")):
			_servidorOnline = false
		else:
			_servidorOnline = true
			_lastRespost = response
		posTest = true
	else:
		var data = JSON.new()
		data.parse(response)
		_lastRespost = data.data
		processEstado()
	emit_signal("_respostaRecebida")

func _verificarOnline():
	return _servidorOnline
