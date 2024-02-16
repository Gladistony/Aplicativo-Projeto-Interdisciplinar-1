extends Control

@onready var _nome = $"Box/Box Nome" as LineEdit
@onready var _senha1 = $Box/BoxSenha as LineEdit
@onready var _senha2 = $Box/BoxSenha2 as LineEdit
@onready var _email = $Box/BoxEmail as LineEdit
@onready var _calendarioDia = $Box/BoxCalendario/Data/Dia as LineEdit
@onready var _calendarioMes = $Box/BoxCalendario/Data/Mes as LineEdit
@onready var _calendarioAno = $Box/BoxCalendario/Data/Ano as LineEdit
@onready var _check = $"Outros/BotãoCheck"
@onready var loadBox = $CaixaLoad as Control

func _charge():
	loadBox.visible = not loadBox.visible
	if loadBox.visible:
		$Botoes.visible = false
		$Box.visible = false
		$Outros .visible = false
	else:
		$Botoes.visible = true
		$Box.visible = true
		$Outros .visible = true

func get_date():
	return _calendarioDia.text + '-' +  _calendarioMes.text  + '-' + _calendarioAno.text

func _ready():
	Firebase.Auth.signup_succeeded.connect(_on_signup_succeeded)
	Firebase.Auth.signup_failed.connect(on_signup_failed)

func _on_botao_volta_pressed():
	get_tree().change_scene_to_file("res://Telas/Inicio/01 - Tela de Entrada.tscn")

func _on_botao_registro_pressed():
	get_tree().change_scene_to_file("res://Telas/Inicio/02 - Tela de Login.tscn")

func _on_botao_fundo_azul_pressed():
	if len(_nome.text) < 5:
		VariaveisGlobais.print("Nome invalido")
	elif _calendarioDia.text == "" or _calendarioMes.text == "" or _calendarioAno.text == "":
		VariaveisGlobais.print("Data de nascimento invalido")
	elif _senha1.text != _senha2.text:
		VariaveisGlobais.print("As senhas devem ser iguais")
	elif not _check._check:
		VariaveisGlobais.print("Você deve aceitar os termos de uso")
	else:
		var email = _email.text
		var password = _senha1.text
		_charge()
		Firebase.Auth.signup_with_email_and_password(email, password)

func on_signup_failed(error_code, message):
	_charge()
	if message == "INVALID_EMAIL":
		VariaveisGlobais.print("Email invalido")
	elif  message == "MISSING_PASSWORD":
		VariaveisGlobais.print("Senha Invalida")
	elif message == "WEAK_PASSWORD":
		VariaveisGlobais.print("Crie uma senha mais forte, com ao menos 6 digitos")
	elif message == "EMAIL_EXISTS":
		VariaveisGlobais.print("Esse email já está sendo usado")
	else:
		VariaveisGlobais.print(message)

func _on_signup_succeeded(user):
	DadosCliente._fazerLogin(user, _email.text, _senha1.text)
	#Firebase.Auth.save_auth(user)
	VariaveisGlobais._ModoLogado = true
	VariaveisGlobais._ModoOff = false
	VariaveisGlobais._carregamentoInicialCompleto = true
	envidarDadosConta()
	get_tree().change_scene_to_file("res://Telas/Principal/00 - Main.tscn")

func envidarDadosConta():
	var auth = Firebase.Auth.auth
	if auth.localid:
		var colllection: FirestoreCollection = Firebase.Firestore.collection("registros")
		var data: Dictionary = {
			"Nome": _nome.text,
			"DataNascimento": get_date()
		}
		DadosCliente.saveColec = data
		DadosCliente._data["backupData"] = data
		var task: FirestoreTask = colllection.update(auth.localid, data)
