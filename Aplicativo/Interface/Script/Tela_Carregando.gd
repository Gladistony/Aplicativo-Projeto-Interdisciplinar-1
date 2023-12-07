extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimacaoRodando.play("Load")
	#verificar se o servidor está online
	if NetWork._verificarOnline():
		DadosCliente._modoOffLine = false
		print("O servidor está online")
	else:		
		print("O servidor não está online, ajustar o cliente para o modo offline")

func _on_timer_timeout():
	#fazer a conexão com o servidor
	get_tree().change_scene_to_file("res://Tela/tela_load.tscn")
