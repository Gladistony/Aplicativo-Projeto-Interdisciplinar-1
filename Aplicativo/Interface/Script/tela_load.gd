extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_login_pressed():
	get_tree().change_scene_to_file("res://Tela/tela_login.tscn")


func _on_entrar_sem_cadastro_pressed():
	get_tree().change_scene_to_file("res://Tela/tela_principal.tscn")


func _on_registrar_pressed():
	get_tree().change_scene_to_file("res://Tela/Tela Registro.tscn")
