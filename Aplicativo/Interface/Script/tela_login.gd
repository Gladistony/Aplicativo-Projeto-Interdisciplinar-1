extends Control

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Tela/tela_load.tscn")


func _on_botão_registro_pressed():
	get_tree().change_scene_to_file("res://Tela/Tela Registro.tscn")


func _on_login_pressed():
	NetWork._tryLogin($BoxEmail/Email/Usuario.text, $BoxSenha/fundo/Usuario.text)
	#get_tree().change_scene_to_file("res://Tela/tela_principal.tscn")
