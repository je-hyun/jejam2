# This class should be used as an interface.
# Defines all info needed to change the base piece of a piece.
# Pawn - sprite_resource / animations, legal_moves(...)->Array[Vector2i]
class_name iBasePiece
extends Resource

func get_legal_moves(board: BoardModel) -> Array[Vector2i]:
	assert(false, "[%s] get_legal_moves must be overridden." % self)
	return []

func get_base_sprite() -> Resource:
	assert(false, "[%s] get_base_sprite must be overridden." % self)
	return null
