# Implements state and gameplay related methods for a piece (state changers)
# ❌ DO NOT implement graphics
# ❌ DO NOT manage board state
# ✅ DO implement legal moves, state (including position) via composition

class_name PieceModel

extends Resource

@export var coordinates:Vector2i
@export var base_piece:Enums.BasePieces :
	set(value):
		base_piece = value
# TODO: how do enchantments work?

func set_coordinates(value:Vector2i) -> void:
	coordinates = value

func get_coordinates() -> Vector2i:
	return coordinates;

func get_legal_moves(board: BoardModel) -> Array[Vector2i]:
	var result: Array[Vector2i] = []
	
	if null == board.get_pieces()[coordinates.x][coordinates.y - 1]:
		if board.get_spaces()[coordinates.x][coordinates.y-1]:
			result.append(Vector2i(coordinates.x, coordinates.y - 1))
	return result
