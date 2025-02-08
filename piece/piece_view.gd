# Implements methods that:
# 1. displays visuals (sprite, effects, animations) for the piece
# 2. signals input events like starting drag, clicking, ending drag.
# 3. disables input events (but not logic for when)
# >>> Do NOT include logic for movement or game logic
# >>> DO simply provide methods and signals

class_name PieceView
extends Control

signal dragged()
signal dropped(target_space:Vector2i)

var dragging:bool = false
var base_piece: Enums.BasePieces

func set_coordinates(value: Vector2i):
	position = _coordinates_to_position(value)

func _snap_position(coordinate: Vector2, snap_amount:int=100) -> Vector2:
	return Vector2(
		clamp(int(coordinate.x)/snap_amount*snap_amount,0,1800), clamp(int(coordinate.y)/snap_amount*snap_amount,0,1000)
	)

func _position_to_coordinates(_position:Vector2) -> Vector2i:
	var result:Vector2i = Vector2i(
		clamp(int(_position.x/100),0,18), clamp(int(_position.y/100),0,10)
	)
	return result

func _coordinates_to_position(coordinate:Vector2i) -> Vector2:
	var result:Vector2 = Vector2(
		100 * coordinate.x,
		100 * coordinate.y
	)
	return result


func _on_button_down() -> void:
	dragging = true
	dragged.emit()

func _on_button_up() -> void:
	dragging = false
	global_position = _snap_position(get_viewport().get_mouse_position())
	dropped.emit(_position_to_coordinates(_snap_position(get_viewport().get_mouse_position())))
	
func _input(event:InputEvent) -> void:
	if event is InputEventMouseMotion and dragging:
		global_position = get_viewport().get_mouse_position() - size/2

func _ready() -> void:
	assert(owner is PieceController, "Owner should be a piece controller (signal connections made based on that assumption)")
	dragged.connect(owner._piece_dragged)
	dropped.connect(owner._piece_dropped)
