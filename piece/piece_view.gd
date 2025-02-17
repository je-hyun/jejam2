# Implements methods that:
# 1. displays visuals (sprite, effects, animations) for the piece
# 2. signals input events like starting drag, clicking, ending drag.
# 3. disables input events (but not logic for when)
# >>> Do NOT include logic for movement or game logic
# >>> DO simply provide methods and signals
class_name PieceView
extends Control
const SWITCH_11 = preload("res://audio/sfx/switch11.ogg")

const BLACK_ROOK = preload("res://piece_assets/black_rook.bmp")
const WHITE_ROOK = preload("res://piece_assets/white_rook.bmp")
signal try_drag()
signal try_drop(target_space:Vector2i)

var _dragging:bool = false
var _base_piece: iBasePiece
var _previous_global_position: Vector2

func set_base_piece(value:iBasePiece) -> void:
	_base_piece = value

func set_dragging(value:bool):
	_dragging = value
	%heat_sfx.play(SWITCH_11)
	if value:
		%button.set_default_cursor_shape(Control.CURSOR_DRAG)
	if not value:
		%button.set_default_cursor_shape(Control.CURSOR_POINTING_HAND)

func set_coordinates(value: Vector2i):
	set_global_position( _coordinates_to_position(value))

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
	try_drag.emit()
	_previous_global_position = global_position

func snap_to_previous_position():
	global_position = _previous_global_position

func _on_button_up() -> void:
	if _dragging:
		global_position = _snap_position(get_viewport().get_mouse_position())
		try_drop.emit(_position_to_coordinates(_snap_position(get_viewport().get_mouse_position())))
		set_dragging(false)
const MOUSE_OFFSET = Vector2(-8,-4)
func _input(event:InputEvent) -> void:
	if event is InputEventMouseMotion and _dragging:
		global_position = get_viewport().get_mouse_position() - size/2 - MOUSE_OFFSET

func initialize_piece_view():
	assert(owner is PieceController, "Owner (%s) should be a piece controller (signal connections made based on that assumption)" % owner)
	%button.set_default_cursor_shape(Control.CURSOR_POINTING_HAND)
	try_drag.connect(owner._try_drag)
	try_drop.connect(owner._try_drop)

func set_team(value:Enums.Teams) -> void:
	match value:
		Enums.Teams.BLACK:
			%sprite.texture = BLACK_ROOK
		Enums.Teams.WHITE:
			%sprite.texture = WHITE_ROOK
