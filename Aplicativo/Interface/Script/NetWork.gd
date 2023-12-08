extends Node

var http_request = HTTPRequest.new()
var servidor = "https://deploy-api-pgp.onrender.com"
var _servidorOnline = false
var _esperando = false
var _lastRespost

func _ready():
	#Criar um network e adicionar ele como filho nesse nó 
	add_child(http_request)
	http_request.connect("request_completed", _request_completed)
	var body = JSON.stringify({"login": "teste@teste.com", "senha":"123"})
	#var error = http_request.request("https://httpbin.org/post", [], HTTPClient.METHOD_POST, body)
	var error = http_request.request(servidor+"/login", [], HTTPClient.METHOD_POST, body)
	_esperando = true
	if error != OK:
		_servidorOnline = false
		#push_error("An error occurred in the HTTP request.")

func converter_ASCIIToString(lista):
	var new_string = ""
	for code in lista:
		var charString = String.chr(code)
		new_string += charString
	return new_string
	
func _request_completed(_result, _response_code, _headers, body):
	var response = converter_ASCIIToString(body)
	_esperando = false
	# Will print the user agent string used by the HTTPRequest node (as recognized by httpbin.org).
	if (response == null) or (response.contains("suspend")):
		_servidorOnline = false
	else:
		_servidorOnline = true
		_lastRespost = response

func _verificarOnline():
	return _servidorOnline
