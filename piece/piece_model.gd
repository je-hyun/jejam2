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

func get_legal_moves(board: Array[Array]) -> Vector2i: #TODO: What type is board? flesh out
	return Vector2.ZERO
