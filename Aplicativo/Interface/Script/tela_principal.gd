extends Control

@onready var menuLateral = get_node("MenuLateral")
var recuar = false

# Called when the node enters the scene tree for the first time.
func _ready():
	menuLateral.connect("foraDaTela",_fecharMenu)
	
func _fecharMenu():
	recuar = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if menuLateral.visible and menuLateral.position.x < 0 and not recuar:
		menuLateral.position.x += delta*1500
	if menuLateral.position.x > 0:
		menuLateral.position.x = 0
	if recuar:
		menuLateral.position.x -= delta*1500
		if menuLateral.position.x <= -512:
			recuar = false
			menuLateral.position.x = -512
			menuLateral.visible = false
		


func _on_botão_menu_lateral_pressed():
	menuLateral.visible = true
