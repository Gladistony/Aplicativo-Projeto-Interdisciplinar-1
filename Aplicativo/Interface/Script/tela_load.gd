extends Control

#@onready var TexturaCinza = preload("res://Recursos/Cinza.gdshader")

# Called when the node enters the scene tree for the first time.
func _ready():
	if DadosCliente._modoOffLine:
		$"Botões/Login".disabled = true
		$"Botões/Registrar".disabled = true
		$"Botões/Login/Label".text = "----"
		$"Botões/Registrar/Label2".text = "----"


func _on_login_pressed():
	get_tree().change_scene_to_file("res://Tela/tela_login.tscn")


func _on_entrar_sem_cadastro_pressed():
	get_tree().change_scene_to_file("res://Tela/tela_principal.tscn")


func _on_registrar_pressed():
	get_tree().change_scene_to_file("res://Tela/Tela Registro.tscn")
