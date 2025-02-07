extends Piece
signal dragged(node:Piece)
signal dropped(node:Piece)

var dragging:bool = false

func _on_button_down() -> void:
	dragging = true
	dragged.emit(self)

func _on_button_up() -> void:
	dragging = false
	global_position = Vector2(int(get_viewport().get_mouse_position().x)/100*100, int(get_viewport().get_mouse_position().y)/100*100)
	dropped.emit(self)
	
func _input(event:InputEvent) -> void:
	if event is InputEventMouseMotion and dragging:
		global_position = get_viewport().get_mouse_position() - size/2
		
func _ready() -> void:
	assert(owner.name == "main", "Owner should be main (signal connections made based on that assumption)")
	dragged.connect(owner.piece_dragged)
	dropped.connect(owner.piece_dropped)
	
func _process(delta: float) -> void:
	pass
