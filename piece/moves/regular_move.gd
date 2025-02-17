class_name RegularMove
extends Resource

var source:PieceController
var target:Vector2i

func move():
	source.set_coordinates(target)

func get_target_piece() -> PieceController:
	return Globals.board.get_piece(target)
