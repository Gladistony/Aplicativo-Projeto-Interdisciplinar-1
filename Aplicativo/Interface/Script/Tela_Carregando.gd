extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimacaoRodando.play("Load")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	#fazer a conexão com o servidor
	get_tree().change_scene_to_file("res://Tela/tela_load.tscn")
