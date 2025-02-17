# This class holds information about a move
# Approach 1: move function takes in all the info needed for the move. (can't array this then)
# Approach 2: first set all the move info in object, then have a separate move function (array friendly, better)


class_name IMove
extends Resource

var source:PieceController
var target:Vector2i

func move(source:PieceController, target_coordinates:Vector2i):
	assert(false, "This is an interface, don't instantiate directly.")

func set_source(value:PieceController):
	print(get_class())
	source = value

func set_target_coordinates(value:Vector2i):
	print(get_class())
	target = value
