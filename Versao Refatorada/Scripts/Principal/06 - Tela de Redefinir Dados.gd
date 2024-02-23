extends Control

@onready var usuario = $"Box/Box Nome" as LineEdit
@onready var senha = $Box/BoxAlterarSenha as LineEdit
@onready var email = $Box/BoxEmail as LineEdit
@onready var _calendarioDia = $Box/BoxCalendario/Data/Dia as LineEdit
@onready var _calendarioMes = $Box/BoxCalendario/Data/Mes as LineEdit
@onready var _calendarioAno = $Box/BoxCalendario/Data/Ano as LineEdit
# Called when the node enters the scene tree for the first time.
func _ready():
	usuario.editable  = false
	email.editable  = false
	senha.editable  = false
	_calendarioDia.editable = false
	_calendarioMes.editable = false
	_calendarioAno.editable = false
	
	_pega_os_dados()
		

func _on_voltar_pressed():
	get_tree().change_scene_to_file("res://Telas/Principal/03 - Tela de Configuracao.tscn")


func _on_salvar_pressed():
	pass # Replace with function body.

func _pega_os_dados():
	usuario.text = DadosCliente.get_nome()
	email.text = DadosCliente.get_email()
	senha.text = DadosCliente.get_senha()
	# Supondo que DadosCliente.get_nascimento() retorna uma string no formato "dia/mês/ano"
	var nascimento = DadosCliente.get_nascimento()

	# Verificar se a string de nascimento não é nula
	if nascimento != null:
		# Dividir a string usando "/" como delimitador
		var partes_data = nascimento.split("/")
		# Verificar se há partes suficientes
		if partes_data.size() == 3:
			 # Convertendo as partes para inteiros
			_calendarioDia = partes_data[0].to_int()
			_calendarioMes = partes_data[1].to_int()
			_calendarioAno = partes_data[2].to_int()
		else:
			print("Formato de data inválido.")
	else:
		print("A string de nascimento é nula.")

	if (usuario.text == "Usuario sem cadastro"):
		if VariaveisGlobais._ModoLogado and not VariaveisGlobais._ModoOff :
			VariaveisGlobais._carregamentoInicialCompleto = false
			usuario.text = "Ainda Carregando ..."

func _on_renomear_nome_pressed():
	usuario.editable  = true


func _on_renomear_email_pressed():
	email.editable  = true


func _on_renomear_data_pressed():
	_calendarioDia.editable = true
	_calendarioMes.editable = true
	_calendarioAno.editable = true
