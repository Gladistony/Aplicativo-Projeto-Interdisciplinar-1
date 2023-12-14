extends Control

@onready var menuBaixo = get_node("MenuH")
var file_dialog = FileDialog.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	menuBaixo.connect("BotaoMenu",menuPrincipal)
	menuBaixo.connect("BotaoPesquisa",_pesquisaRemedio)
	file_dialog.mode = FileDialog.FILE_MODE_OPEN_FILE
	file_dialog.filters = [["Imagens", "*.png; *.jpg; *.bmp"]]
	file_dialog.connect("file_selected", _on_file_selected)
	add_child(file_dialog)

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
	file_dialog.popup_centered()

func _on_file_selected(path):
	var image = Image.new()
	var error = image.load(path)
	if error != OK:
		# Trata o erro
		print("Erro ao carregar a imagem: ", error)
		return
		# Cria uma textura da imagem
	var texture = ImageTexture.new()
	$"FotoPadrão".texture = texture
