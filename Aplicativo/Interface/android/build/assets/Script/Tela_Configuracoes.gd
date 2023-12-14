extends Control

@onready var menuBaixo = get_node("MenuH")
var plugginFoto;
var esperandoImagem = false

# Called when the node enters the scene tree for the first time.
func _ready():
	menuBaixo.connect("BotaoMenu",menuPrincipal)
	menuBaixo.connect("BotaoPesquisa",_pesquisaRemedio)
	if Engine.has_singleton("GodotGetImage"):
		plugginFoto = Engine.get_singleton("GodotGetImage")
		plugginFoto.connect("image_request_completed", _on_image_request_completed)
		plugginFoto.connect("error", _on_error)
		plugginFoto.connect("permission_not_granted_by_user", _on_permission_not_granted_by_user)
		print("Plugin de camera carregado com sucesso")
	else:
		print("Could not load plugin")


func _on_image_request_completed(dict):
	esperandoImagem = false
	for img_buffer in dict.values():
		var image = Image.new()
		# Use load format depending what you have set in plugin setOption()
		var error = image.load_jpg_from_buffer(img_buffer)
		#var error = image.load_png_from_buffer(img_buffer)
		if error != OK:
			print("Error loading png/jpg buffer, ", error)
		else:
			print("We are now loading texture... ")
			var image_node = $"FotoPadrão"
			image_node.texture = ImageTexture.new().create_from_image(image)

func _on_error(e):
	var dialog = get_node("AcceptDialog")
	dialog.window_title = "Error!"
	dialog.dialog_text = e
	dialog.show()

func _on_permission_not_granted_by_user(permission):
	print("User won't grant permission, explain why it's important!")
	var dialog = get_node("AcceptDialog")
	dialog.window_title = "Permission necessary"
	var permission_text = permission.capitalize().split(".")[-1]
	dialog.dialog_text = permission_text + "\n permission is necessary"
	dialog.show()
	# Set the plugin to ask user for permission again
	plugginFoto.resendPermission()

func _pesquisaRemedio():
	get_tree().change_scene_to_file("res://Tela/Tela_Pesquisa.tscn")

func menuPrincipal():
	get_tree().change_scene_to_file("res://Tela/tela_principal.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_botão_voltar_pressed():
	if DadosCliente._retornoPrincipal:
		DadosCliente._retornoPrincipal = false
		get_tree().change_scene_to_file("res://Tela/tela_principal.tscn")
	else:
		get_tree().change_scene_to_file("res://Tela/Tela_Perfil.tscn")


func _on_botao_editar_foto_pressed():
	if plugginFoto and not esperandoImagem:
		esperandoImagem = true
		var dict = {
		"image_height" : 887,
		"image_width" : 960,
		"keep_aspect" : false,
		"auto_rotate_image" : true,
		"image_quality" : 20,
		"image_format" : "png",
		"use_front_camera": true
		}
		plugginFoto.setOptions(dict)
		plugginFoto.getCameraImag()
