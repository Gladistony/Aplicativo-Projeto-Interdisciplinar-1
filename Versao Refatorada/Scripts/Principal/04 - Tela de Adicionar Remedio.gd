extends Control

@onready var menuBaixo = get_node("Menu Abaixo")
@onready var nome_remedio = $"Dados do medicamento/Nome/Nome Remedio"
@onready var substancia = $"Dados do medicamento/Substancia"
@onready var substanciaLabel = $"Dados do medicamento/Substancia/Label"
@onready var fabricante = $"Dados do medicamento/Fabricante"
@onready var fabricanteLabel = $"Dados do medicamento/Fabricante/Label"
@onready var tarja = $"Dados do medicamento/Tarja"
@onready var tarjaLabel = $"Dados do medicamento/Tarja/Label"
@onready var aviso_tarja = $"Dados do medicamento/AvisoTarja"
@onready var repetir = $"Dados do medicamento/Horarios/Repetir"
@onready var repeticao = $"Dados do medicamento/Repeticao"
@onready var b_4_hr = $"Dados do medicamento/Repeticao/B4hr"
@onready var b_6_hr = $"Dados do medicamento/Repeticao/B6hr"
@onready var b_8_hr = $"Dados do medicamento/Repeticao/B8hr"
@onready var b_12_hr = $"Dados do medicamento/Repeticao/B12hr"
@onready var b_24_hr = $"Dados do medicamento/Repeticao/B24hr"
@onready var hora = $"Dados do medicamento/Horarios/Hora"
@onready var minutos = $"Dados do medicamento/Horarios/Minutos"
@onready var aviso_data = $"Dados do medicamento/Aviso Data"
@onready var data_inicio = $"Dados do medicamento/Datas/Data Inicio"
@onready var data_fim = $"Dados do medicamento/Datas/Data Fim"
@onready var box_calendario_2 = $"Dados do medicamento/BoxCalendario2"
@onready var box_calendario = $"Dados do medicamento/BoxCalendario"
@onready var dosagem = $"Dados do medicamento/Dosagem/Dosagem"
@onready var lista_de_lembretes = $"Dados do medicamento/Lista de Lembretes"
var caixaLembrete = load("res://Recursos/Componentes/Box Auxiliar Listagem Lembrete Simples.tscn")

var lembretes = []

var corFoco = Color.from_string("407bff", Color.AQUA)

func dataInicio(stado):
	$"Dados do medicamento/LabelDataInicio".visible = stado
	$"Dados do medicamento/BoxCalendario".visible = stado
	$"Dados do medicamento/Separacao2".visible = stado
	aviso_data.visible = $"Dados do medicamento/LabelDataInicio".visible or $"Dados do medicamento/LabelDataFim".visible

func dataFim(stado):
	$"Dados do medicamento/LabelDataFim".visible = stado
	$"Dados do medicamento/BoxCalendario2".visible = stado
	$"Dados do medicamento/Separacao3".visible = stado
	aviso_data.visible = $"Dados do medicamento/LabelDataInicio".visible or $"Dados do medicamento/LabelDataFim".visible
	
# Called when the node enters the scene tree for the first time.
func _ready():
	menuBaixo.connect("BotaoMenu",menuPrincipal)
	menuBaixo.connect("BotaoPerfil",_janelaPerfil)
	menuBaixo.connect("BotaoPesquisa", botaopesquisa)
	repeticao.visible = false
	dataFim(false)
	dataInicio(false)
	aviso_data.visible = false
	if VariaveisGlobais.PesquisaNome != "":
		nome_remedio.text = VariaveisGlobais.PesquisaNome
		substanciaLabel.text = VariaveisGlobais.PesquisaSubstancia
		fabricanteLabel.text = VariaveisGlobais.PesquisaFabricante
		tarjaLabel.text = VariaveisGlobais.PesquisaTarja
		VariaveisGlobais._LimparAdicicaoRemedio()
		var strtrab = tarjaLabel.text.to_lower()
		if strtrab.count("vermelh") > 0 or strtrab.count("pret") > 0:
			aviso_tarja.visible = true
		else:
			aviso_tarja.visible = false
	else:
		ocultarDados()

func ocultarDados():
	substancia.visible = false
	fabricante.visible = false
	tarja.visible = false
	aviso_tarja.visible = false

func _janelaPerfil():
	VariaveisGlobais._LimparAdicicaoRemedio()
	get_tree().change_scene_to_file("res://Telas/Principal/02 - Perfil de Usuario.tscn")

func menuPrincipal():
	VariaveisGlobais._LimparAdicicaoRemedio()
	get_tree().change_scene_to_file("res://Telas/Principal/00 - Main.tscn")

func botaopesquisa():
	VariaveisGlobais._LimparAdicicaoRemedio()
	get_tree().change_scene_to_file("res://Telas/Principal/01 - Tela de Busca.tscn")

func _on_busca_medicamento_pressed():
	VariaveisGlobais._StartPesquisa = nome_remedio.text
	get_tree().change_scene_to_file("res://Telas/Principal/01 - Tela de Busca.tscn")


func _on_repetir_pressed():
	if repetir.get_theme_color("font_color") == corFoco:
		repetir.add_theme_color_override("font_color",Color.BLACK)
		repeticao.visible = false
	else:	
		repetir.add_theme_color_override("font_color",corFoco) #font_color(corFoco)
		repeticao.visible = true
		definirHora(b_8_hr)

func definirHora(hora):
	var list = [b_4_hr,b_6_hr,b_8_hr,b_12_hr,b_24_hr]
	for defi in list:
		if defi == hora:
			defi.add_theme_color_override("font_color",corFoco)
		else:
			defi.add_theme_color_override("font_color",Color.BLACK)

func _on_hora_text_changed(new_text):
	var number = int(new_text)
	if number >= 24 or number < 0:
		hora.text = "00"

func _on_minutos_text_changed(new_text):
	var number = int(new_text)
	if number >= 60 or number < 0:
		minutos.text = "00"

func _on_b_4_hr_pressed():
	definirHora(b_4_hr)

func _on_b_6_hr_pressed():
	definirHora(b_6_hr)

func _on_b_8_hr_pressed():
	definirHora(b_8_hr)

func _on_b_12_hr_pressed():
	definirHora(b_12_hr)

func _on_b_24_hr_pressed():
	definirHora(b_24_hr)

func _on_hora_focus_entered():
	hora.text = ""

func _on_minutos_focus_entered():
	minutos.text = ""

func _on_adicionar_pressed():
	if len(lembretes) < VariaveisGlobais.LimiteHorarios:
		var _hora = int(hora.text)
		var _min = int(minutos.text)
		var _repetir = repeticao.visible
		var _intervalo = 0
		if _repetir:
			for busc in [b_4_hr,b_6_hr,b_8_hr,b_12_hr,b_24_hr]:
				if busc.get_theme_color("font_color") == corFoco:
					_intervalo = int(busc.text.substr(0,2))
					break
		repetir.add_theme_color_override("font_color",Color.BLACK)
		data_fim.add_theme_color_override("font_color",Color.BLACK)
		data_inicio.add_theme_color_override("font_color",Color.BLACK)
		var data = {
			"hora": _hora,
			"min": _min,
			"rep": _repetir,
			"inter":_intervalo,
			"dataInicio": box_calendario._get_Data(true),
			"dataFim": box_calendario_2._get_Data(true),
			"dose": dosagem.text
		}
		dosagem.text = ""
		hora.text = ""
		minutos.text = ""
		dataFim(false)
		dataInicio(false)
		repeticao.visible = false
		aviso_data.visible = false
		lembretes.append(data)
		atualizar_lembretes()
	else:
		VariaveisGlobais.print("Apenas é possivel ter 5 horarios")

func excluir_lembrete(data):
	var id = -1
	for i in lembretes:
		id += 1
		if i == data:
			break
	if id != -1:
		lembretes.remove_at(id)
	atualizar_lembretes()

func atualizar_lembretes():
	#apagar todos os lembrentes listados
	for filhos in lista_de_lembretes.get_children():
		filhos.queue_free()
	#Adicionar novos lembretes com o horario e repetição
	for da in lembretes:
		var temp = caixaLembrete.instantiate()
		temp.load_data(da)
		temp.connect("excluir", excluir_lembrete)
		lista_de_lembretes.add_child(temp)

func _on_data_fim_pressed():
	if  data_fim.get_theme_color("font_color") == corFoco:
		data_fim.add_theme_color_override("font_color",Color.BLACK)
		dataFim(false)
	else:	
		data_fim.add_theme_color_override("font_color",corFoco) #font_color(corFoco)
		dataFim(true)

func _on_data_inicio_pressed():
	if  data_inicio.get_theme_color("font_color") == corFoco:
		data_inicio.add_theme_color_override("font_color",Color.BLACK)
		dataInicio(false)
	else:	
		data_inicio.add_theme_color_override("font_color",corFoco) #font_color(corFoco)
		dataInicio(true)


func _on_adicionar_medicamento_pressed():
	if len(nome_remedio.text) < 2:
		VariaveisGlobais.print("Digite um nome de medicamento")
	elif len(lembretes) == 0:
		VariaveisGlobais.print("Defina ao menos 1 horario")
	else:
		var data = {
			"remedio":nome_remedio.text,
			"Horarios": lembretes
		}
		DadosCliente.medicamentos.append(data)
		DadosCliente.enviarMedicamentos()
		get_tree().change_scene_to_file("res://Telas/Principal/00 - Main.tscn")
