extends Control

var _data = {}
signal  excluir(data)

func load_data(data):
	_data = data
	if _data['hora'] == null:
		_data['hora'] = 0
	if _data['min'] == null:
		_data['min'] = 0
	var inicio = _data['dataInicio'] as String
	inicio = inicio.split('-')
	if len(inicio) > 2 and len(inicio[0]) > 0:
		var dia = inicio[0]
		var mes = inicio[1]
		var agora = Time.get_datetime_dict_from_system()
		if int(dia) == 0:
			dia = agora.day
		if int(mes) == 0:
			mes = agora.month			
		$Organizador/horario.text = "%02d/%02d %02d : %02d" % [int(dia), int(mes), _data['hora'],_data['min']]
	else:
		$Organizador/horario.text = "%02d : %02d" % [_data['hora'],_data['min']]
	if int(_data["inter"]) > 0:
		$Organizador/horario.text += " Rep"


func _on_excluir_pressed():
	excluir.emit(_data)
