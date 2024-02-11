extends Control

func verificar_senha(senha):
 # Define os critérios para uma senha forte
	var tamanho_minimo = 8
	var tem_maiuscula = false
	var tem_minuscula = false
	var tem_numero = false
	var tem_simbolo = false
  # Define os símbolos permitidos na senha
	var simbolos = "!@#$%&*()-_=+[]{};:,.<>/?\\|`~"
  # Percorre cada caractere da senha e verifica se atende aos critérios
	for caractere in senha:
			if caractere in "ABCDEFGHIJKLMNOPQRSTUVWXYZ":
				tem_maiuscula = true
			elif caractere in "abcdefghijklmnopqrstuvwxyz":
				tem_minuscula = true
			elif caractere in "0123456789":
				tem_numero = true
			elif caractere in simbolos:
				tem_simbolo = true
  # Retorna verdadeiro se a senha tiver pelo menos o tamanho mínimo e todos os tipos de caracteres, e falso caso contrário
	return senha.length() >= tamanho_minimo and tem_maiuscula and tem_minuscula and tem_numero and tem_simbolo

func _on_botão_voltar_pressed():
	get_tree().change_scene_to_file("res://Tela/tela_load.tscn")

func _on_criar_conta_pressed():
	var senha = $BoxSenha2/fundo/Usuario.text
	if verificar_senha(senha):
		
		get_tree().change_scene_to_file("res://Tela/tela_principal.tscn")
	else:
		get_tree().change_scene_to_file("res://Tela/tela_aviso.tscn")

		

func _on_botão_entrar_pressed():
	get_tree().change_scene_to_file("res://Tela/tela_login.tscn")
