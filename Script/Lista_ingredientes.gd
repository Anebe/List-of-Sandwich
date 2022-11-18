extends ItemList

var img_ingr = load("res://Resource/Imagens_Ingredientes.tres")

func _ready():

	for i in img_ingr.frames:
		var novo = img_ingr.duplicate()
		novo.current_frame = i
		add_icon_item(novo)
	pass


#func _process(delta):
#	pass
