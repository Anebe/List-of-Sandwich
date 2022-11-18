extends Panel


onready var tempo = $Tempo_restante
onready var tempo_barra = $VBoxContainer/Barra_tempo
onready var ingrediente = $VBoxContainer/Ingrediente
onready var operacao = $VBoxContainer/HBoxContainer/Operacao
onready var index = $VBoxContainer/HBoxContainer/Label

func _ready():
	
	pass 

func _run_time():
	tempo_barra.value = tempo.time_left*100 / tempo.wait_time
	pass

func _process(_delta):
	
	_run_time()
	pass

func _on_Tempo_restante_timeout():
	queue_free()
	pass # Replace with function body.

func _criar(ing_frame:int, op_frame:int, index_novo:int):
#	ingrediente.texture.current_frame = randi() % ingrediente.texture.frames
#	operacao.texture.current_frame = randi() % operacao.texture.frames
	ingrediente.texture.current_frame = ing_frame
	operacao.texture.current_frame = op_frame
	index.text = String(index_novo)
	pass

func _completou_pedido(frame_ing:int, frame_op, index_test:int):
	if frame_ing == ingrediente.texture.current_frame:
		if index_test == int(index.text):
			if frame_op == operacao.texture.current_frame:
				queue_free()
				return true
	pass

func _equals(frame_ing:int, frame_op, index_test:int):
	if frame_ing == ingrediente.texture.current_frame:
		if index_test == int(index.text):
			if frame_op == operacao.texture.current_frame and frame_op == 1:
				return true
	return false
	pass

func _get_operacao():
	return operacao.texture.current_frame
	pass
