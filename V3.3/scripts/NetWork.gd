extends Node

var http_request = HTTPRequest.new()
var servidor = "https://deploy-api-pgp.onrender.com"

var _servidorLigado = false
var _token = null
var _IDConta = 0
var _lastRespost = null
var posTest = false
var _stado = 0 #Estado 0, não logado estado 1 logado

signal resposta


func _sendMsg(metodo, corpo, url):
	if _servidorLigado:
		var cabeca = ["Content-Type: application/json"]
		if _token != null:
			var toke = "Authorization: Bearer "+_token
			cabeca.append(toke)
		var body = JSON.stringify(corpo)
		return http_request.request(servidor+url, cabeca,true, metodo , body)

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(http_request)
	http_request.connect("request_completed", self, "_on_request_completed")
	var body = JSON.print({"login": "teste@teste.com", "senha":"123"})
	var error = http_request.request(servidor+"/login", ["Content-Type: application/json"],true,HTTPClient.METHOD_POST,body)
	# HTTPClient.METHOD_POST , body)
	if error != OK:
		_servidorLigado = false

func converter_ASCIIToString(lista):
	var new_string = ""
	for code in lista:
		var charString =char(code)
		new_string += charString
	return new_string

func _on_request_completed(_result, _response_code, _headers, body):
	var response = converter_ASCIIToString(body)
	if not posTest:
		if (response == null) or (response.count("suspend") > 0) or (len(response) < 10):
			_servidorLigado = false
			_lastRespost = "suspend"
		else:
			_servidorLigado = true
			_lastRespost = response
		posTest = true
	else:
		#var data = JSON.new()
		var parsed_json: JSONParseResult = JSON.parse(response)
		if not parsed_json.error:
			_lastRespost = parsed_json.result
		else:
			_lastRespost = response
		processarResposta()
		#data.parse(response)
	emit_signal("resposta")

func _tryLogin(email,senha):
	if _servidorLigado:
		var body = JSON.print({"login": email, "senha":senha})
		var error = http_request.request(servidor+"/login", ["Content-Type: application/json"],true, HTTPClient.METHOD_POST , body)
		if error != OK:
			_servidorLigado = false


func processarResposta():
	if _stado == 0:
		processPreLogin()
	elif _stado == 1:
		processPosLogin()

func processPreLogin():
	if _lastRespost is Dictionary and _lastRespost.has("token"):
		_token = _lastRespost.token
		_IDConta = _lastRespost.contaId
		_stado = 1
		#Receber informações de conta
		var error = _sendMsg( HTTPClient.METHOD_GET, "{}", "/cadastro/"+_IDConta)
		if error != OK:
			_servidorLigado = false

func processPosLogin():
	if _lastRespost is Dictionary and _lastRespost.has("nome"):
		var nome = _lastRespost.nome
		var data = _lastRespost.dataNascimento
		var foto = _lastRespost.fotoPerfil
		print("Nome: "+nome+" Data: "+data+" Foto: "+foto)
		print(_lastRespost)
