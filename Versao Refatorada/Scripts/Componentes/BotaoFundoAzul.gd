extends TextureButton

@export var TextoBotao = ""
@onready var labelButton = $Label as Label

# Called when the node enters the scene tree for the first time.
func _ready():
	labelButton.text = TextoBotao
