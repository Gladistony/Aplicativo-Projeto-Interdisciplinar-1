extends Control

@onready var animador = $"Rotacao LoadBar" as AnimationPlayer
@onready var labelStatus = $Label as Label

func _charceStade(newStade):
	labelStatus.text = newStade;

# Called when the node enters the scene tree for the first time.
func _ready():
		#inciar a animação
	animador.play("Rottate")
	#ajustar janela quando testado no windows
	if OS.get_name() == "Windows":
		get_tree().root.set_content_scale_aspect(Window.CONTENT_SCALE_ASPECT_KEEP)
	#conectar sinais
	BancoDeDados._readEnd.connect(finalLeituraBanco)
	Firebase.Auth.login_failed.connect(on_login_failed)
	Firebase.Auth.login_succeeded.connect(_on_login_succeeded)


func _on_iniciar_programa_timeout():
	_charceStade("Carregando banco de dados ...")
	BancoDeDados._loadData()

func finalLeituraBanco():
	_charceStade("Recebendo dados do servidor ...")
	#Verificar Stadus do Usuario
	if DadosCliente._estadoUsuario():
		if DadosCliente._eatadoLogado():
			VariaveisGlobais._ModoLogado = true
			DadosCliente._requestLogin()
		else:
			VariaveisGlobais._ModoLogado = false
			get_tree().change_scene_to_file("res://Telas/Principal/00 - Main.tscn")
	else:
		_charceStade("Tentando conectar ao servidor ...")
		Firebase.Auth.login_with_email_and_password("Nenhum email valido", "Senha em branco")

func on_login_failed(error_code, _message):
	if str(error_code) == "Connection error":
		VariaveisGlobais._ModoOff = true
		if DadosCliente._eatadoLogado():
			#load_banco_dados_serv()
			get_tree().change_scene_to_file("res://Telas/Principal/00 - Main.tscn")
		else:
			get_tree().change_scene_to_file("res://Telas/Inicio/01 - Tela de Entrada.tscn")
	else:
		VariaveisGlobais._ModoOff = false
		if DadosCliente._eatadoLogado():
			load_banco_dados_serv()
		else:
			get_tree().change_scene_to_file("res://Telas/Inicio/01 - Tela de Entrada.tscn")

func _on_login_succeeded(user):
	DadosCliente._fazerLogin(user, DadosCliente.get_login(), DadosCliente.get_senha())
	Firebase.Auth.save_auth(user)
	VariaveisGlobais._ModoOff = false
	VariaveisGlobais._ModoLogado = true
	load_banco_dados_serv()
	#get_tree().change_scene_to_file("res://Telas/Principal/00 - Main.tscn")

func load_banco_dados_serv():
	VariaveisGlobais._carregamentoInicialCompleto = true
	if DadosCliente._estadoUsuario() and DadosCliente._eatadoLogado() and DadosCliente.registrado():
		if not VariaveisGlobais._ModoOff:
			var auth = Firebase.Auth.auth
			if auth.localid:
				var colllection: FirestoreCollection = Firebase.Firestore.collection("registros")
				var task: FirestoreTask = colllection.get_doc(auth.localid)
				task.task_finished.connect(tarefa_finalizada)
				#var finished_task: FirestoreTask = await task.task_finished
				
		else:
			DadosCliente.saveColec = DadosCliente._data["backupData"]

func tarefa_finalizada(finished_task):
	var documento = finished_task.document
	VariaveisGlobais._ModoLogado = true
	DadosCliente.saveColec = documento.doc_fields
	DadosCliente._data["backupData"] = documento.doc_fields
	DadosCliente._saveData()
	get_tree().change_scene_to_file("res://Telas/Principal/00 - Main.tscn")
