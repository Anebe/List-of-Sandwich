extends Panel


var ingrediente = load("res://Cenas/Ingrediente_jogador.tscn")
onready var conexao = $"Conexão"

var ingredientes = []
var ing_selecionado

func _ready():
	pass

func _process(_delta):
	_move_conexao()
	pass


func _add(index_ingrediente:int):
	
	var novo = ingrediente.instance()
	var index = ingredientes.find(ing_selecionado)
	ingredientes.insert(index+1, novo)
	add_child(novo)
	novo.rect_position = ingredientes[index].rect_position + novo.rect_size
	novo._create(index_ingrediente, index)
	_update_index()
	conexao.add_point(Vector2.ZERO, ingredientes.size())
	
	if ingredientes.size() == 1:
		ing_selecionado = ingredientes[0]
		ing_selecionado._select(true)
		
	return [novo._get_frame_ing(),index+1]
	pass

func _select_next():
	if ingredientes.size() > 0:
		ing_selecionado._select(false)
		
		var index = ingredientes.find(ing_selecionado)
		
		if index+1 == ingredientes.size():
			ing_selecionado = ingredientes[0]
		else:
			ing_selecionado = ingredientes[index+1]
		
		ing_selecionado._select(true)
	pass

func _remove():
	var index = ingredientes.find(ing_selecionado)
	var ing_remove = ing_selecionado
	var frame_img = ing_remove._get_frame_ing()
	
	conexao.remove_point(index)
	ingredientes.remove(index)
	ing_remove.queue_free()
	
	_select_next()
	_update_index()
	
	return [frame_img,index]
	pass

func _update_index():
	for i in ingredientes.size():
		ingredientes[i]._set_index(i)
	pass
	
func _move_conexao():
	if(ingredientes.size() > 0):
		for i in ingredientes.size():
			var position =  ingredientes[i].rect_position + ingredientes[i].rect_size/2
			conexao.set_point_position(i, position)
	pass


func exist_ingredient(img_frame:int):
	for i in ingredientes:
		if i.texture.current_frame == img_frame:
			return true
	return false
	pass

func has_ingrediente():
	if ingredientes.size() > 0:
		return true
	return false
