extends Node

onready var lista_jogador = $HSplitContainer/HSplitContainer/Lista_jogador
onready var lista_ingrediente = $HSplitContainer/Lista_ingredientes
onready var lista_pedido = $HSplitContainer/HSplitContainer/Lista_pedido

enum {ADICIONAR, REMOVER}

func _ready():
	randomize()
	adicionar_ingrediente(7)
	_on_Tempo_criar_pedido_timeout()
	pass 

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Lista_ingredientes_item_selected(index):
	var index_image = lista_ingrediente.get_item_icon(index).current_frame
	lista_ingrediente.unselect(index)
	
	active_all_buttons(true)
	lista_ingrediente.visible = false
	adicionar_ingrediente(index_image)
	pass # Replace with function body.


func active_all_buttons(op:bool):
	for i in get_children():
		if i is TextureButton:
			i.disabled = !op
	pass

func adicionar_ingrediente(ing_frame):
	var testar_pedido = lista_jogador._add(ing_frame)
	lista_pedido._verifica_pedidos(testar_pedido[0], ADICIONAR, testar_pedido[1])
	pass

func _on_Criar_button_up():
	lista_ingrediente.visible = true
	active_all_buttons(false)
	pass # Replace with function body.


func _on_Proximo_button_up():
	lista_jogador._select_next()
	pass


func _on_Remover_button_up():
	if lista_jogador.has_ingrediente() and lista_jogador.ingredientes.size() > 1:
		var info = lista_jogador._remove()
		lista_pedido._verifica_pedidos(info[0], REMOVER, info[1])
	pass # Replace with function body.


func _on_Tempo_criar_pedido_timeout():
	var index:int
	var img_frame:int
	var op_frame:int
	
	
	while true:
		if lista_jogador.ingredientes.size() == 0:
			op_frame = ADICIONAR
			index = 0
			img_frame = randi() % lista_ingrediente.get_item_count()
		else:
			if lista_jogador.ingredientes.size() > 1:
				if randi() % 10 > 4:	op_frame = ADICIONAR
				else:	op_frame = REMOVER
			else:
				op_frame = ADICIONAR
			
			if op_frame == REMOVER:
				index = randi() % (lista_jogador.ingredientes.size())
				if index == 0: index += 1
				img_frame = lista_jogador.ingredientes[index]._get_frame_ing()
			else:
				index = (randi() % (lista_jogador.ingredientes.size())) + 1
				img_frame = randi() % lista_ingrediente.get_item_count()
		
		if lista_pedido._is_pedido_repetido(img_frame, op_frame, index) == false:
			break
		else: print(lista_pedido.local_adicionar.get_child_count())
	lista_pedido._criar(img_frame, op_frame, index)
	pass # Replace with function body.


