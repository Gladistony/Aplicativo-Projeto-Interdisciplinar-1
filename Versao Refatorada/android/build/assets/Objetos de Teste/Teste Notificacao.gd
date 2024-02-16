extends Node2D

var _plugin_name = "extrasgladistony"
var _plugin_singleton
var ID_Colecao = "registros"

func _init():
	if Engine.has_singleton(_plugin_name):
		_plugin_singleton = Engine.get_singleton(_plugin_name)
	else:
		printerr("Initialization error: unable to access the java logic")

## Shows a 'Hello World' toast.
func helloWorld():
	if _plugin_singleton:
		_plugin_singleton.avisosPrint('Senha muito curta!!')
	else:
		printerr("Initialization error")

func mostraNotificacao():
	if _plugin_singleton:
		_plugin_singleton.acionarNotificacao('Esta na hora de tomar o IBUPROFENO!!', 'Lembrete Remedio',5,1)
	else:
		printerr("Initialization error")

func mostraNotification2():
	if _plugin_singleton:
		_plugin_singleton.acionarNotificacaoBotao('Esta na hora de tomar o IBUPROFENO!!', 'Lembrete Remedio',5,1,'Adiar','Tomado')
	else:
		printerr("Initialization error")

func cancelarNotificacao():
	if _plugin_singleton:
		_plugin_singleton.cancelarNotificacao(1)
	else:
		printerr("Initialization error")

func _ready():
	Firebase.Auth.login_succeeded.connect(_on_login_succeeded)
	Firebase.Auth.signup_succeeded.connect(_on_signup_succeeded)
	Firebase.Auth.login_failed.connect(on_login_failed)
	Firebase.Auth.signup_failed.connect(on_signup_failed)
	$Label.set_text(OS.get_user_data_dir())


func _on_button_pressed():
	mostraNotificacao()


func _on_button_2_pressed():
	cancelarNotificacao()


func _on_button_3_pressed():
	var email = $LineEdit.text
	var password = $LineEdit2.text
	Firebase.Auth.login_with_email_and_password(email, password)
	$Label.text = "Logando ..."

func _on_button_4_pressed():
	var email = $LineEdit.text
	var password = $LineEdit2.text
	Firebase.Auth.signup_with_email_and_password(email, password)
	$Label.text = "Registrando ..."
	
func _on_login_succeeded(user):
	$Label.set_text("Successfully logged ")
	pegarDocumentos()

func _on_signup_succeeded(user):
	$Label.set_text("Successfully signup ")
	pegarDocumentos()

func on_login_failed(error_code, message):
	print("error code: " + str(error_code))
	print("message: " + str(message))
	$Label.set_text("")

func on_signup_failed(error_code, message):
	print("error code: " + str(error_code))
	print("message: " + str(message))
	$Label.set_text("")

func pegarDocumentos():
	var auth = Firebase.Auth.auth
	if auth.localid:
		var colllection: FirestoreCollection = Firebase.Firestore.collection(ID_Colecao)
		var data: Dictionary = {
			"Nome": "GladisTeeste",
			"DataNascimento": "27/09/1993"
		}
		var task: FirestoreTask = colllection.update(auth.localid, data)
