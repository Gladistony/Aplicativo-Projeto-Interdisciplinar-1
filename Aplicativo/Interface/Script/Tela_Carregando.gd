extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	#OS.alert(str(DisplayServer.screen_get_size())+" / "+str(get_viewport().size))
	#get_viewport().size = DisplayServer.screen_get_size()
	if OS.get_name() == "Windows":
		get_tree().root.set_content_scale_aspect(Window.CONTENT_SCALE_ASPECT_KEEP)
		#display/window/stretch/aspect
	$AnimacaoRodando.play("Load")	
	#DadosCliente._modoOffLine = false

func _on_timer_timeout():
	#verificar se o servidor está online
	if NetWork._verificarOnline():
		DadosCliente._modoOffLine = false
		print("O servidor está online")
	else:		
		print("O servidor não está online, ajustar o cliente para o modo offline")
	#fazer a conexão com o servidor
	get_tree().change_scene_to_file("res://Tela/tela_load.tscn")
