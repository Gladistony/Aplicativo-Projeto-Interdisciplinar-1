extends Control

@onready var senha = $"Box e Botoes/Box/BoxSenha" as LineEdit
@onready var email = $"Box e Botoes/Box/BoxEmail" as LineEdit
@onready var Bvoltar = $"Box e Botoes/Botoes/Botao Volta" as Button
@onready var Bregistar = $"Box e Botoes/Botoes/Botao Registro" as Button
@onready var Blogin = $"Box e Botoes/Botoes/Botao Login" as TextureButton
@onready var LoadCX = $CaixaLoad as Node


# Called when the node enters the scene tree for the first time.
func _ready():
	Firebase.Auth.login_succeeded.connect(_on_login_succeeded)
	Firebase.Auth.login_failed.connect(on_login_failed)

func _charge():
	LoadCX.visible = not LoadCX.visible
	if LoadCX.visible:
		Bvoltar.disabled = true
		Bregistar.disabled = true
		Blogin.visible = false
		senha.editable = false
		email.editable = false
	else:
		Bvoltar.disabled = false
		Bregistar.disabled = false
		Blogin.visible = true
		senha.editable = true
		email.editable = true

func _on_botao_volta_pressed():
	get_tree().change_scene_to_file("res://Telas/Inicio/01 - Tela de Entrada.tscn")


func _on_botao_registro_pressed():
	get_tree().change_scene_to_file("res://Telas/Inicio/03 - Tela de Registro.tscn")


func _on_botao_login_pressed():
	var _usuario = email.text
	var _senha = senha.text
	_charge()
	Firebase.Auth.login_with_email_and_password(_usuario, _senha)

func _on_login_succeeded(user):
	DadosCliente._fazerLogin(user,email.text, senha.text)
	var auth = Firebase.Auth.auth
	if auth.localid:
		var colllection: FirestoreCollection = Firebase.Firestore.collection("registros")
		var task: FirestoreTask = colllection.get_doc(auth.localid)
		task.task_finished.connect(tarefa_finalizada)
	#get_tree().change_scene_to_file("res://Telas/Principal/00 - Main.tscn")

func tarefa_finalizada(finished_task):
	var documento = finished_task.document
	VariaveisGlobais._ModoLogado = true
	DadosCliente.saveColec = documento.doc_fields
	DadosCliente._data["backupData"] = documento.doc_fields
	DadosCliente._saveData()
	get_tree().change_scene_to_file("res://Telas/Principal/00 - Main.tscn")

func on_login_failed(error_code, message):
	_charge()
	if message == "INVALID_EMAIL":
		VariaveisGlobais.print("Email Invalido")
	elif  message == "MISSING_PASSWORD":
		VariaveisGlobais.print("Senha Invalida")
	else:
		VariaveisGlobais.print("Login ou senha incorretos")
