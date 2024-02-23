extends Control

var tempoAtual = Time.get_unix_time_from_system() #verificar a troca para um objeto DateTime, caso precise
var tempoNotifica = DateTime.new()
var tempoNotificaSeg

func _ready(): 
	defineHorario(tempoNotifica, 2024, 2, 22, 20 ,30)
	tempoNotificaSeg = emSegundos(tempoNotifica)

func _process(delta): #talvez colocar a atualização do unix na tela de carregamento
	tempoAtual = Time.get_unix_time_from_system()

func verificaAnoBissexto(year: int) -> bool:
	return (year % 4 == 0 and (year % 100 != 0 or year % 400 == 0))

func emSegundos(dicionarioT: DateTime) -> int:
	var segundos = 0

	# Calcular segundos a partir dos anos bissextos
	for ano in range(1970, dicionarioT.year):
		if (verificaAnoBissexto(ano)):
			segundos += 366 * 24 * 60 * 60
		else:
			segundos += 365 * 24 * 60 * 60

	# Calcular segundos a partir dos meses
	var diasNoMes = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
	if verificaAnoBissexto(dicionarioT.year):
		diasNoMes[1] = 29

	for mes in range(0, dicionarioT.month -1):
		segundos += diasNoMes[mes] * 24 * 60 * 60

	# Calcular segundos a partir dos dias, horas, minutos e segundos
	segundos += (dicionarioT.day - 1) * 24 * 60 * 60
	segundos += dicionarioT.hour * 60 * 60
	segundos += dicionarioT.minute * 60
	segundos += dicionarioT.second

	return segundos

func defineHorario(tempoHorario: DateTime,ano: int, mes: int, dia: int, hora: int, min: int):
	tempoHorario.year = ano #fazer verificação para os próximos anos também
	tempoHorario.month = mes
	tempoHorario.day = dia
	tempoHorario.hour = hora + 3 # por conta do horário UTC
	tempoHorario.minute = min
