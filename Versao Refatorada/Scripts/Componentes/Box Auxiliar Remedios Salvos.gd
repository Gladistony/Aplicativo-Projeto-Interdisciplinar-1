extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _setNomeRemedio(nome):
	$"Remédio".text = nome

func _setHoraRemedio(hora):
	$"Horário".text = hora
