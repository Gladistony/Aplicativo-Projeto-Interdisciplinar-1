extends Control

@onready var menuBaixo = get_node("Menu Abaixo")
@onready var usuario = get_node("Dados/Nome Conta")
@onready var email = get_node("Dados/Email")
@onready var nascimento = get_node("Dados/Nascimento")
@onready var editFoto = get_node("Botoes/Edit Foto")
@onready var boxLoad = get_node("Box Load Foto")
@onready var _foto = get_node("Box Load Foto/Sprite2D") as Sprite2D
@onready var fotoPerfil = get_node("Dados/Foto/FotoPerfil") as Sprite2D

var plugin
var plugin_name = "GodotGetImage"
var imagemData = null

func load_foto():
	imagemData = DadosCliente.load_foto()
	if imagemData != null:
		var image = Image.new()
		var error = image.load_jpg_from_buffer(imagemData)
		if error != OK:
			print("Error loading png/jpg buffer, ", error)
		else:
			fotoPerfil.texture = ImageTexture.new().create_from_image(image)
			var x = 520.0 / fotoPerfil.texture.get_width()
			var y = 505.0 / fotoPerfil.texture.get_height()
			fotoPerfil.scale = Vector2(x,y)

# Called when the node enters the scene tree for the first time.
func _ready():
	menuBaixo.connect("BotaoMenu",menuPrincipal)
	menuBaixo.connect("BotaoPesquisa",_pesquisaRemedio)
	usuario.text = DadosCliente.get_nome()
	email.text = DadosCliente.get_email()
	var idade = DadosCliente.get_idade()
	nascimento.text = DadosCliente.get_String_Nascimento()
	if idade > 5:
		nascimento.text += " (%d anos)"%idade
	if (usuario.text == "Usuario sem cadastro"):
		if VariaveisGlobais._ModoLogado and not VariaveisGlobais._ModoOff :
			VariaveisGlobais._carregamentoInicialCompleto = false
			usuario.text = "Ainda Carregando ..."
		email.visible = false
		nascimento.visible = false
		editFoto.visible = false
	else:
		email.visible = true
		nascimento.visible = true
		editFoto.visible = true
		load_foto()
	if Engine.has_singleton(plugin_name):
		plugin = Engine.get_singleton(plugin_name)
	else:
		print("Could not load plugin: ", plugin_name)

	if plugin:
		plugin.connect("image_request_completed", _on_image_request_completed)
		plugin.connect("error", _on_error)
		plugin.connect("permission_not_granted_by_user", _on_permission_not_granted_by_user)
		var dict = {
			"image_height" : 570,
			"image_width" : 570,
			"keep_aspect" : true,
			"use_front_camera": true
		}
		plugin.setOptions(dict)
func _pesquisaRemedio():
	get_tree().change_scene_to_file("res://Telas/Principal/01 - Tela de Busca.tscn")

func menuPrincipal():
	get_tree().change_scene_to_file("res://Telas/Principal/00 - Main.tscn")

func _sairConta():
	DadosCliente._fazerLogOff()
	get_tree().change_scene_to_file("res://Telas/Inicio/00 - Tela de Carregamento.tscn")

func _on_log_out_pressed():
	_sairConta()

func _on_voltar_pressed():
	get_tree().change_scene_to_file("res://Telas/Principal/00 - Main.tscn")

func _on_configuracoes_pressed():
	get_tree().change_scene_to_file("res://Telas/Principal/03 - Tela de Configuracao.tscn")

func _on_edit_foto_pressed():
	boxLoad.visible = true

func _on_carregar_galeria_pressed():
	if plugin:
		plugin.getGalleryImage()
	else:
		print(plugin_name, " plugin not loaded!")

func _on_pegar_camera_pressed():
	if plugin:
		plugin.getCameraImage()
	else:
		print(plugin_name, " plugin not loaded!")

func _on_aceitar_pressed():
	boxLoad.visible = false
	DadosCliente.send_foto(imagemData)
	load_foto()

func _on_recusar_pressed():
	boxLoad.visible = false

func _on_image_request_completed(dict):
	for img_buffer in dict.values():
		var image = Image.new()
		var error = image.load_jpg_from_buffer(img_buffer)
		imagemData = str(img_buffer) 
		if error != OK:
			print("Error loading png/jpg buffer, ", error)
		else:
			_foto.texture = ImageTexture.new().create_from_image(image)
			_foto.scale.x = (382.47-40.0) / _foto.texture.get_width()
			_foto.scale.y = (322.62-40.0) / _foto.texture.get_height()
			#382,47
			#322,62

func _on_error(e):
	VariaveisGlobais.print("Erro ao carregar")
	boxLoad.visible = false

func _on_permission_not_granted_by_user(permission):
	VariaveisGlobais.print("A permissão é nescessaria")
	plugin.resendPermission()


func _on_salvos_pressed():
	get_tree().change_scene_to_file("res://Telas/Principal/05 Tela de Remedios Salvos.tscn")
