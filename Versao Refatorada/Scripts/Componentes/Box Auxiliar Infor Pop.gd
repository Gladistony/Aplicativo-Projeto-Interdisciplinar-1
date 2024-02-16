extends HBoxContainer

@export var NomePropriedade = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	$Propriedade.text = NomePropriedade

func _setInformacao(texto):
	$Label.text = texto
