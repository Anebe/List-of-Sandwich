extends Panel

onready var ingrediente_image = $Ingrediente
onready var index_label = $Label
onready var select = $ColorRect
var is_to_move:bool = false

func _ready():
	pass 

func _process(_delta):
	_move()
	pass

func _move():
	if is_to_move:
		#rect_position = get_global_mouse_position() - rect_size/2
		
		rect_position += get_local_mouse_position() - rect_size/2
		if rect_position.y < 0:
			rect_position.y = 0
		if rect_position.x < 0:
			rect_position.x = 0

		if rect_position.y > get_parent().rect_size.y - rect_size.y:
			rect_position.y = get_parent().rect_size.y - rect_size.y
		if rect_position.x > get_parent().rect_size.x - rect_size.x:
			rect_position.x = get_parent().rect_size.x - rect_size.x
	pass

func _on_Ingrediente_jogador_gui_input(event):
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed("mouse_left"):
			is_to_move = true
			raise()
		elif Input.is_action_just_released("mouse_left"):
			is_to_move = false

	pass

func _set_index(index: int):
	$Label.text = String(index)
	pass

func _create(index_ingrediente:int, index:int):
	_set_index(index)
	ingrediente_image.texture.set_current_frame(index_ingrediente)
	pass

func _select(op: bool):
	select.visible = op
	pass
	
func _get_frame_ing():
	return ingrediente_image.texture.get_current_frame()
	pass
