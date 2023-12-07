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
	var body = JSON.stringify({"login": "Godette", "senha":"senha normal"})
	#var error = http_request.request("https://httpbin.org/post", [], HTTPClient.METHOD_POST, body)
	var error = http_request.request(servidor+"/login", [], HTTPClient.METHOD_POST, body)
	_esperando = true
	if error != OK:
		_servidorOnline = false
		#push_error("An error occurred in the HTTP request.")


func _request_completed(_result, _response_code, _headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	_esperando = false
	# Will print the user agent string used by the HTTPRequest node (as recognized by httpbin.org).
	if response == null:
		_servidorOnline = false
	else:
		_servidorOnline = true
		_lastRespost = response
	#print(response)

func _verificarOnline():
	return _servidorOnline
