#TODO: rn the piece moves when clicked. make it ask main if it's movable before dragging.
# TODO: rn the piece moves when released. make it ask main if it's a valid spot.

class_name Main
extends Control
const SPACE_CONTROLLER = preload("res://space/space_controller.tscn")

var board:BoardModel

#var dragging_piece:PieceNode
#
func piece_dragged(piece:PieceController):
	pass
func piece_dropped(piece:PieceController, coordinate:Vector2i):
	pass

const PIECE_CONTROLLER = preload("res://piece/piece_controller.tscn")

func initialize_board():
	# Initialize board spaces
	var board_spaces: Array[Array]
	board_spaces.resize(18)
	for i in board_spaces.size():
		board_spaces[i].resize(10)
		for j in range(board_spaces[i].size()):
			var current_space_controller = SPACE_CONTROLLER.instantiate()
			board_spaces[i][j] = current_space_controller
			current_space_controller.initialize()
			current_space_controller.set_coordinates(Vector2i(i,j))
			%board.add_child(current_space_controller)
			current_space_controller.owner = self
			current_space_controller.set_enabled(false)
	
	for i in range(Globals.A1.x, Globals.H8.x+1):
		for j in range(Globals.H8.y, Globals.A1.y+1):
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
	
	for i in [Globals.A1, Globals.A8, Globals.H1, Globals.H8]:
		new_controller = PIECE_CONTROLLER.instantiate()
		#new_controller.initialize_signals()
		%pieces.add_child(new_controller)
		new_controller.owner = self
		new_controller.initialize_piece(RookBasePiece.new())
		new_controller.set_coordinates(i)
		board_pieces[i.x][i.y] = new_controller
		if i == Globals.A1:
			new_controller.set_team(Enums.Teams.BLACK)
		else:
			new_controller.set_team(Enums.Teams.WHITE)
	
	board = BoardModel.new()
	board._initialize()
	board.set_pieces(board_pieces)
	board.set_spaces(board_spaces)
	Globals.set_board(board)
	
func _ready() -> void:
	initialize_board()

	
func _try_drag(piece_controller:PieceController) -> void:
	piece_controller.drag()
	board.clear_space_highlights()
	for i in piece_controller.get_legal_moves(board):
		board.get_spaces()[i.x][i.y].set_highlight(true)

func _try_drop(piece_controller:PieceController, target_coordinates:Vector2i) -> void:
	board.clear_space_highlights()
	if target_coordinates in piece_controller.get_legal_moves(board):
		var source_coordinates:Vector2i = piece_controller.get_coordinates()
		board.move_piece(source_coordinates, target_coordinates)
		piece_controller.drop(target_coordinates)
		
	else:
		piece_controller.drop(piece_controller.get_coordinates())

func _captured(source:PieceController, target:PieceController) -> void:
	for i in range(18):
		assert(source.get_team() == Enums.Teams.BLACK or source.get_team() == Enums.Teams.WHITE)
		var capture_jail_spot:Vector2i
		if source.get_team() == Enums.Teams.BLACK:
			capture_jail_spot = Vector2i(i,0)
		elif source.get_team() == Enums.Teams.WHITE:
			capture_jail_spot = Vector2i(i,9)
		
		if board.get_piece(capture_jail_spot) == null:
			board.move_piece(target.get_coordinates(),capture_jail_spot)
			break

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("toggle_debug"):
		_is_debugging = !_is_debugging
		debug_toggled(_is_debugging)
		

var _is_debugging:bool = false
func debug_toggled(value:bool) -> void:
	board.debug_toggled(value)
	#TODO make this useful
