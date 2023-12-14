extends Node

signal _respostaRecebida

var http_request = HTTPRequest.new()
var servidor = "https://deploy-api-pgp.onrender.com"
var _servidorOnline = false
var _esperando = false
var _lastRespost #ultima resposta recebida pelo servidor
var posTest = false #depois de verificar se o servidor já foi testado pra login
var Stado = 0 #Estado 0, não logado estado 1 logado
var _tokenLogin = "" #Salva o token do login
var _IDConta = 1 #Salva o ID da conta


func sendMsg(token, metodo, corpo, url):
	var cabeca = ["Content-Type: application/json"]
	if token != null:
		var toke = "Authorization: Bearer "+_tokenLogin
		cabeca.append(toke)
	var body = JSON.stringify(corpo)
	return http_request.request(servidor+url, cabeca, metodo , body)
	

func processEstado():
	print("ultima ",_lastRespost)
	if Stado == 0:
		if _lastRespost is Dictionary and _lastRespost.has("token"):
			Stado = 1
			_tokenLogin = _lastRespost.token
			_IDConta = str(int(_lastRespost.contaId))
			#get_tree().change_scene_to_file("res://Tela/tela_principal.tscn")
			#print(_lastRespost)
			#var body = JSON.stringify({"token": _tokenLogin})
			#var toke = "Authorization: Bearer "+_tokenLogin
			#var error = http_request.request(servidor+"/cadastro/1", ["Content-Type: application/json", toke], HTTPClient.METHOD_GET , "{}")
			var error = sendMsg(_tokenLogin, HTTPClient.METHOD_GET, "{}", "/cadastro/"+_IDConta)
	elif Stado == 1:
		if _lastRespost is Dictionary and _lastRespost.has("nome"):
			var nome = _lastRespost.nome
			var data = _lastRespost.dataNascimento
			var foto = _lastRespost.fotoPerfil
			DadosCliente.receberInfo(nome, data, foto)
			get_tree().change_scene_to_file("res://Tela/tela_principal.tscn")
			Stado = 2
	elif Stado == 2:
		print("teste ",_lastRespost)

func _tryLogin(email,senha):
	if _servidorOnline and not _esperando:
		var body = JSON.stringify({"login": email, "senha":senha})
		var error = http_request.request(servidor+"/login", ["Content-Type: application/json"], HTTPClient.METHOD_POST , body)
		_esperando = true
		DadosCliente.receberLastLogin(email,senha)
		if error != OK:
			_servidorOnline = false
			_esperando = false

func _ready():
	#Criar um network e adicionar ele como filho nesse nó 
	#print("chave: ", cripto("12345"))
	add_child(http_request)
	http_request.connect("request_completed", _request_completed)
	var body = JSON.stringify({"login": "teste@teste.com", "senha":"123"})
	var error = http_request.request(servidor+"/login", ["Content-Type: application/json"], HTTPClient.METHOD_POST , body)
	_esperando = true
	if error != OK:
		_servidorOnline = false
		_esperando = false

func converter_ASCIIToString(lista):
	var new_string = ""
	for code in lista:
		var charString = String.chr(code)
		new_string += charString
	return new_string
	
func _request_completed(_result, _response_code, _headers, body):
	var response = converter_ASCIIToString(body)
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


func gerarSalto():
	randomize()
	var salt = str(randi()).sha256_text()
	return salt

func cripto(passw):
	var hashed_pass = passw
	var rounds = 10
	var salt = gerarSalto()
	while rounds > 0:
		hashed_pass  = (hashed_pass + salt).sha256_text()
		rounds -= 1
	return ("$5$10$"+hashed_pass)
