extends Node

var _data = {} #Armazena os dados do usuario
var saveColec = {}
var medicamentos = []


func enviarMedicamentos():
	saveColec['medicamentos'] = str(medicamentos)
	envidarDadosConta()

func processarMedicamentos():
	if saveColec.has('medicamentos'):
		medicamentos = []
		for processando in str_to_var(saveColec['medicamentos']):
			medicamentos.append(processando)

func get_idade():
	if _data["login"]:
		var time = int(string_para_data(DadosCliente.get_nascimento()))
		var agora = int(Time.get_unix_time_from_system())
		var idade = (agora - time)/(60*60*24*365)
		if idade > 5 and idade < 100:
			return int(idade)
		else:
			return 0
	else:
		return 0

func send_foto(data):
	saveColec['foto'] = data
	envidarDadosConta()

func load_foto():
	if saveColec.has('foto'):
		return str_to_var(saveColec['foto'])
	else:
		return null

func envidarDadosConta():
	var auth = Firebase.Auth.auth
	if auth.localid:
		var colllection: FirestoreCollection = Firebase.Firestore.collection("registros")
		DadosCliente.saveColec = saveColec
		DadosCliente._data["backupData"] = saveColec
		var task: FirestoreTask = colllection.update(auth.localid, saveColec)

func get_String_Nascimento():
	var date = string_para_data(get_nascimento())
	date = Time.get_datetime_dict_from_unix_time(date)
	return "%02d / %02d / %02d" % [date.day, date.month, date.year]

func registrado():
	return len(saveColec) == 0

func get_nome():
	if saveColec.has("Nome") and _data["login"]:
		return saveColec["Nome"]
	else:
		return "Usuario sem cadastro"

func get_nascimento():
	if saveColec.has("DataNascimento") and _data["login"]:
		return saveColec["DataNascimento"]
	else:
		return ""

func get_email():
	if _data["login"]:
		return _data["usuario"]
	else:
		return ""

func _estadoUsuario() -> bool:
	if _data.has("estado"):
		return _data["estado"]
	else:
		_data["estado"] = false
		_saveData()
		return false

func _eatadoLogado() -> bool:
	if _data.has("login"):
		return _data["login"]
	else:
		return false

func _requestLogin():
	Firebase.Auth.login_with_email_and_password(_data["usuario"], _data["senha"])

func _fazerLoginSemCadastro():
	_data["estado"] = true
	_data["login"] = false
	saveColec = {}
	_saveData()

func _fazerLogin(user, usuario, senha):
	_data["estado"] = true
	_data["dados"] = user
	_data["usuario"] = usuario
	_data["senha"] = senha
	_data["login"] = true
	_saveData()

func get_login():
	if _data.has("usuario"):
		return _data["usuario"]
	else:
		return "1234"

func get_senha():
	if _data.has("senha"):
		return _data["senha"]
	else:
		return "1234"

func _fazerLogOff():
	_data["estado"] = false
	_data["dados"] = null
	_data["usuario"] = ""
	_data["senha"] = ""
	_data["login"] = false
	saveColec = {}
	DadosCliente._data["backupData"] = {}
	#Firebase.Auth.remove_auth()
	_saveData()

func _ready():
	_loadData()

func _loadData():
	if FileAccess.file_exists("user://dadosLocais.datLife"):
		var arq = FileAccess.open("user://dadosLocais.datLife",FileAccess.READ)
		var jsonstr =  arq.get_as_text()
		arq.close()
		var data = JSON.new()
		data.parse(jsonstr)
		_data = data.data

func _saveData():
	var file = FileAccess.open("user://dadosLocais.datLife", FileAccess.WRITE)
	file.store_line(JSON.stringify(_data))
	file.close()

func string_para_data(str):
	# Tenta separar a string em três partes: dia, mês e ano
	var partes = str.split("-")
	if partes.size() == 3:
		# Tenta converter cada parte para um número inteiro
		var dia = int(partes[0])
		var mes = int(partes[1])
		var ano = int(partes[2])
		# Verifica se os valores são válidos para uma data
		if dia > 0 and dia <= 31 and mes > 0 and mes <= 12 and ano > 0:
			# Cria uma data com os valores obtidos Time.get_datetime_dict_from_unix_time
			var data = Time.get_unix_time_from_datetime_dict({year = ano, month = mes, day = dia})
			# Retorna a data
			return data
	# Se a string não for válida, retorna a data atual
	return 0
