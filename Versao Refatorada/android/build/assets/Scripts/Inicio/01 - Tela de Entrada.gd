extends Control

@onready var logo = $Logo as Sprite2D
@onready var BotaoEntrar = $Entrar as TextureButton
@onready var BotaoEntrarSemCadastro = $EntrarSemCadastro as TextureButton
@onready var BotaoRegistrar = $Registrar as TextureButton

# Called when the node enters the scene tree for the first time.
func _ready():
	if VariaveisGlobais._ModoOff:
		logo.position.x = 224
		logo.position.y = 448
		BotaoEntrar.visible = false
		BotaoRegistrar.visible = false
	else:
		logo.position.x = 224
		logo.position.y = 256
		BotaoEntrar.visible = true
		BotaoRegistrar.visible = true


func _on_entrar_pressed():
	get_tree().change_scene_to_file("res://Telas/Inicio/02 - Tela de Login.tscn")


func _on_entrar_sem_cadastro_pressed():
	DadosCliente._fazerLoginSemCadastro()
	get_tree().change_scene_to_file("res://Telas/Principal/00 - Main.tscn")


func _on_registrar_pressed():
	get_tree().change_scene_to_file("res://Telas/Inicio/03 - Tela de Registro.tscn")
