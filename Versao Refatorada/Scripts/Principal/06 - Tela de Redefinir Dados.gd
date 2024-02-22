extends Control

@onready var usuario = $"Box/Box Nome" as LineEdit
@onready var senha = $Box/BoxAlterarSenha as LineEdit
@onready var email = $Box/BoxEmail as LineEdit
@onready var _calendarioDia = $Box/BoxCalendario/Data/Dia as LineEdit
@onready var _calendarioMes = $Box/BoxCalendario/Data/Mes as LineEdit
@onready var _calendarioAno = $Box/BoxCalendario/Data/Ano as LineEdit
# Called when the node enters the scene tree for the first time.
func _ready():
	usuario.text = DadosCliente.get_nome()
	email.text = DadosCliente.get_email()
	senha.text = DadosCliente.get_senha()
	var nascimento = DadosCliente.get_nascimento()
	if (usuario.text == "Usuario sem cadastro"):
		if VariaveisGlobais._ModoLogado and not VariaveisGlobais._ModoOff :
			VariaveisGlobais._carregamentoInicialCompleto = false
			usuario.text = "Ainda Carregando ..."
		email.visible = false
		nascimento.visible = false
	else:
		email.visible = true
		nascimento.visible = true

func _on_voltar_pressed():
	get_tree().change_scene_to_file("res://Telas/Principal/02 - Perfil de Usuario.tscn")


func _on_salvar_pressed():
	pass # Replace with function body.
