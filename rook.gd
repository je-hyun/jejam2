extends Button


var dragging:bool = false

func _on_button_down() -> void:
	dragging = true
	pass

func _on_button_up() -> void:
	dragging = false
	global_position = global_position + size/2
	global_position = Vector2(int(global_position.x)/100*100, int(global_position.y)/100*100)

func _input(event:InputEvent) -> void:
	if event is InputEventMouseMotion and dragging:
		global_position = get_viewport().get_mouse_position() - size/2
		
func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	pass
