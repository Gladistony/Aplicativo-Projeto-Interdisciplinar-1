extends Node2D




func _on_botão_voltar_pressed():
	get_tree().change_scene_to_file("res://Tela/tela_load.tscn")


func _on_botão_registro_pressed():
	get_tree().change_scene_to_file("res://Tela/tela_login.tscn")


func _on_login_pressed():
	get_tree().change_scene_to_file("res://Tela/tela_principal.tscn")
