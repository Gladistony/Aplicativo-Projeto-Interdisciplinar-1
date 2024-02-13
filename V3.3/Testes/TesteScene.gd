extends Node2D

var _ln = null


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Button_pressed():
	if Engine.has_singleton("LocalNotification"):
		_ln = Engine.get_singleton("LocalNotification")
		_ln.showLocalNotification("Corpo da msg", "Hora de tomar o remedio", 2, 1)
	pass # Replace with function body.
