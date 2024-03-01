extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _setNomeRemedio(nome):
	$"Nome Remédio".text = nome

func _setHoraRemedio(hora):
	$"Horário Remédio".text = hora

func _on_detalhes_do_remédio_pressed():
	get_tree().change_scene_to_file("res://Recursos/Componentes/Box Detalhes do Remédio.tscn")
