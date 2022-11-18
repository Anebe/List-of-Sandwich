extends Panel

var pedido = preload("res://Cenas/Pedido.tscn")
onready var local_adicionar = $ScrollContainer/Container


func _ready():
	pass


func _criar(ing_frame:int, op_frame:int, index:int):
	var novo_pedido = pedido.instance()
	
	local_adicionar.add_child(novo_pedido)
	novo_pedido._criar(ing_frame, op_frame, index)
	pass

func _verifica_pedidos(frame_ing:int, frame_op:int, index_test:int):
	for i in local_adicionar.get_children():
		if i is Panel:
			if i._completou_pedido(frame_ing, frame_op, index_test):
				break
	if frame_op == 1:
		_update_index_when_remove(index_test, -1)
	elif frame_op == 0:
		_update_index_when_remove(index_test, 1)
	pass

func _has_pedidos():
	if local_adicionar.get_child_count() > 0:
		return true
	return false
	pass

func _update_index_when_remove(index:int, op:int):
	var aux_ped
	for i in local_adicionar.get_children():
		aux_ped = int(i.index.text)
		
		if index <= aux_ped:
			i.index.text = String(int(i.index.text)+op)
			if index == 0 and i.index.text=="0" and i._get_operacao()==0:
				i.index.text = "1"
		if int(i.index.text) < 1:
			i.index.text = "0"
		pass
	pass

func _is_pedido_repetido(img_frame, op_frame, index):
	for i in local_adicionar.get_children():
		if i._equals(img_frame, op_frame, index):
			return true
	return false
	pass
