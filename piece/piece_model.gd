# Implements state and gameplay related methods for a piece (state changers)
# ❌ DO NOT implement graphics
# ❌ DO NOT manage board state
# ✅ DO implement legal moves, state (including position) via composition

class_name PieceModel
extends Resource

signal coordinates_moved(value:Vector2i)
signal captured(source:PieceController)

var team:Enums.Teams = Enums.Teams.NONE

@export var coordinates:Vector2i
@export var _base_piece:iBasePiece

func set_base_piece(value:iBasePiece):
	_base_piece = value

func set_team(value:Enums.Teams) -> void:
	team = value

func get_team() -> Enums.Teams:
	return team

func set_coordinates(value:Vector2i) -> void:
	coordinates = value
	emit_signal("coordinates_moved", value)

func get_coordinates() -> Vector2i:
	return coordinates;

func get_legal_moves(board: BoardModel) -> Array[Vector2i]:
	var result: Array[Vector2i] = []
	const UP = Vector2i(0,-1)
	const DOWN = Vector2i(0,1)
	const LEFT = Vector2i(-1,0)
	const RIGHT = Vector2i(1,0)
	
	for direction in [UP,DOWN,LEFT,RIGHT]:
		for i in range(1,18):
			var move_to_check:Vector2i = Vector2i(coordinates.x,coordinates.y) + direction * i
			
			if board.coordinate_moveable(move_to_check):
				result.append(move_to_check)
			elif board.coordinate_capturable(coordinates, move_to_check):
				result.append(move_to_check)
				break
			else:
				break
	return result

func captured_by(source:PieceController) -> void:
	captured.emit(source)

func capture(target:PieceController) -> void:
	pass
