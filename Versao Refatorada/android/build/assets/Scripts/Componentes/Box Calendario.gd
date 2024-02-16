extends Control

func _clear():
	$Data/Dia.text = ""
	$Data/Mes.text = ""
	$Data/Ano.text = ""

func _get_Data(clear = false):
	var resulta = $Data/Dia.text +'-'+ $Data/Mes.text +'-'+ $Data/Ano.text 
	if clear:
		_clear()
	return resulta

# Define uma função que verifica se uma data é válida
func is_valid_date(day, month, year):
	# Define os meses que têm 31 dias
	var months_with_31_days = [1, 3, 5, 7, 8, 10, 12]
	# Verifica se o mês está entre 1 e 12
	if month < 1 or month > 12:
		return false
	# Verifica se o dia está entre 1 e 31
	if day < 1 or day > 31:
		return false
	# Verifica se o mês tem 30 dias e o dia é 31
	if not month in months_with_31_days and day == 31:
		return false
		# Verifica se o mês é fevereiro e o dia é maior que 29
	if month == 2 and day > 29:
		return false
	# Verifica se o ano é bissexto e o mês é fevereiro e o dia é 29
	if year % 4 == 0 and month == 2 and day == 29:
		# Verifica se o ano é divisível por 100 e não por 400
		if year % 100 == 0 and year % 400 != 0:
			return false
	# Se todas as condições forem satisfeitas, retorna verdadeiro
	return true

func _atualizarData():
	#Arrumar o dia
	var new_text = $Data/Dia.text
	if new_text != "":
		var day = int(new_text)
		if day < 1 or day > 31:
			new_text = "1"
			$Data/Dia.set_text(new_text)
			$Data/Dia.set_caret_column(1)
	#arrumar o mes
	new_text = $Data/Mes.text
	if new_text != "":
		var mes = int(new_text)
		if mes < 1 or mes > 12:
			new_text = "1"
			$Data/Mes.set_text(new_text)
			$Data/Mes.set_caret_column(1)
	#arrumar o ano


func _on_dia_text_changed(new_text):
	if len(new_text) > 2:
		if len($Data/Mes.text) < 2:
			$Data/Mes.text += new_text.substr(2, 1)
		new_text = new_text.substr(0, 2)
		$Data/Dia.set_text(new_text)
		$Data/Dia.release_focus()
		$Data/Mes.grab_focus()
		$Data/Mes.set_caret_column(1)
	_atualizarData()


func _on_mes_text_changed(new_text):
	if len(new_text) > 2:
		$Data/Ano.text += new_text.substr(2, 1)
		new_text = new_text.substr(0, 2)
		$Data/Mes.set_text(new_text)
		$Data/Mes.release_focus()
		$Data/Ano.grab_focus()
		$Data/Ano.set_caret_column(1)
	_atualizarData()


func _on_ano_text_changed(new_text):
	_atualizarData()


func _on_ano_focus_exited():
	var new_text = $Data/Ano.text
	if new_text != "":
		var ano = int(new_text)
		if ano < 1900 or ano > 2024:
			new_text = "2000"
			$Data/Ano.set_text(new_text)
			$Data/Ano.set_caret_column(4)
