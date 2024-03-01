extends Control
@onready var JanelaPopUPInfo = get_node("Janela de POP Informacao Remedio")
@onready var popNome = get_node("Janela de POP Informacao Remedio/Box de informacao Vertical/Nome/Label")
@onready var popSubstancia = get_node("Janela de POP Informacao Remedio/Box de informacao Vertical/Substancia/Label")
@onready var popFabricante = get_node("Janela de POP Informacao Remedio/Box de informacao Vertical/Fabricante/Label")
@onready var popDosagem = get_node("Janela de POP Informacao Remedio/Box de informacao Vertical/Apresentacao/Label")
@onready var popClasse = get_node("Janela de POP Informacao Remedio/Box de informacao Vertical/Classe/Label")
@onready var popTarja = get_node("Janela de POP Informacao Remedio/Box de informacao Vertical/Tarja/Label")
@onready var popTipo = get_node("Janela de POP Informacao Remedio/Box de informacao Vertical/Tipo/Label")
@onready var popPreco = get_node("Janela de POP Informacao Remedio/Box de informacao Vertical/Preco Estimado/Label")

var popIDFabricante = 0
var daraRemedioPop = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func monstraPopUpInfo(nomeRemedio):
	JanelaPopUPInfo.move_to_center()
	JanelaPopUPInfo.visible = true
	popIDFabricante = 0
	daraRemedioPop = BancoDeDados._dataRemedio(nomeRemedio)
	#popNome.clear()
	#for fab in daraRemedioPop:
	#	popNome.add_item(fab.produto)
	attPopInfo()

func attPopInfo():
	popNome.text = daraRemedioPop[popIDFabricante].produto
	popSubstancia.text = daraRemedioPop[popIDFabricante].substancia
	popSubstancia.text = popSubstancia.text.replace(";","\n")
	popDosagem.text = daraRemedioPop[popIDFabricante].apresentacao
	popClasse.text = daraRemedioPop[popIDFabricante].classe.replace("/","\n")
	popTarja.text = daraRemedioPop[popIDFabricante].tarja.replace("Tarja ","")
	popTipo.text = daraRemedioPop[popIDFabricante].tipo
	popFabricante.text = daraRemedioPop[popIDFabricante].laboratorio
	popPreco.text = daraRemedioPop[popIDFabricante].estimativa
	if (len(popPreco.text) >= 9) or (len(popPreco.text) <= 1):
		popPreco.text = "Sem cadastro"
	else:
		popPreco.text = "R$ "+popPreco.text


func _on_fechar_pop_pressed():
	JanelaPopUPInfo.visible = false


func _on_excluir_lembrete_pressed():
	pass # Replace with function body.
