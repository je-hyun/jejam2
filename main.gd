#TODO: rn the piece moves when clicked. make it ask main if it's movable before dragging.
# TODO: rn the piece moves when released. make it ask main if it's a valid spot.

class_name Main
extends Control
const SPACE_CONTROLLER = preload("res://space/space_controller.tscn")

var board:BoardModel
# @onready var board: Control = $board

#var dragging_piece:PieceNode
#
func piece_dragged(piece:PieceController):
	print(piece.to_string() + " is being dragged")
	
#
func piece_dropped(piece:PieceController, coordinate:Vector2i):
	print(piece.to_string() + " is being dropped to " + str(coordinate))

const PIECE_CONTROLLER = preload("res://piece/piece_controller.tscn")

const A1 = Vector2i(5,8)
const H8 = Vector2i(5+7,8-7)

func initialize_board():
	# Initialize board spaces
	var board_spaces: Array[Array]
	board_spaces.resize(18)
	for i in board_spaces.size():
		board_spaces[i].resize(10)
		for j in range(board_spaces[i].size()):
			board_spaces[i][j] = SPACE_CONTROLLER.instantiate()
			board_spaces[i][j].initialize()
			board_spaces[i][j].set_coordinates(Vector2i(i,j))
			%board.add_child(board_spaces[i][j])
			board_spaces[i][j].owner = self
			board_spaces[i][j].set_enabled(false)
	
	for i in range(A1.x, H8.x+1):
		for j in range(H8.y, A1.y+1):
			var space_in_default_board:SpaceController = board_spaces[i][j]
			space_in_default_board.set_enabled(true)
	
	# Initialize board pieces
	var board_pieces: Array[Array]
	var new_controller
	board_pieces.resize(18)
	for i in board_pieces:
		i.resize(10)
		for j in range(i.size()):
			i[j] = null
	
	
	for i in [A1, H8]:
		new_controller = PIECE_CONTROLLER.instantiate()
		
		#new_controller.initialize_signals()
		%pieces.add_child(new_controller)
		new_controller.owner = self
		new_controller.initialize_piece()
		new_controller.set_coordinates(i)
		board_pieces[i.x][i.y] = new_controller
	
	board = BoardModel.new()
	board._initialize()
	board.set_pieces(board_pieces)
	board.set_spaces(board_spaces)

func _ready() -> void:
	initialize_board()
	
func _try_drag(piece_controller:PieceController) -> void:
	piece_controller.drag()
	
	for i in piece_controller.get_legal_moves(board):
		board.get_spaces()[i.x][i.y].set_highlight(true)

func _try_drop(piece_controller:PieceController, target_coordinates:Vector2i) -> void:
	if target_coordinates in piece_controller.get_legal_moves(board):
		piece_controller.drop(target_coordinates)
	else:
		piece_controller.drop(piece_controller.get_coordinates())



func _process(delta: float) -> void:
	if Input.is_action_just_pressed("toggle_debug"):
		print("debug pressed")
		_is_debugging = !_is_debugging
		debug_toggled(_is_debugging)
		

var _is_debugging:bool = false
func debug_toggled(value:bool) -> void:
	board.debug_toggled(value)
	#TODO make this useful
