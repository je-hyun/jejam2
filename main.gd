#TODO: rn the piece moves when clicked. make it ask main if it's movable before dragging.
# TODO: rn the piece moves when released. make it ask main if it's a valid spot.

extends Control

var board_spaces: Array[Array] # board spaces
@onready var board: Control = $board

#var dragging_piece:PieceNode
#
func piece_dragged(piece:PieceController):
	print(piece.to_string() + " is being dragged")
#
func piece_dropped(piece:PieceController, coordinate:Vector2i):
	print(piece.to_string() + " is being dropped to " + str(coordinate))
