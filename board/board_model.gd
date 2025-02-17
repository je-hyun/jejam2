class_name BoardModel
extends Resource

var pieces: Array[Array]
var spaces: Array[Array]

const A1 = Vector2i(5,8)
const H8 = Vector2i(5+7,8-7)

func _initialize():
	spaces.resize(18)
	for i in spaces:
		i.resize(10)
	
	for i in range(A1.x, H8.x):
		for j in range(H8.y, A1.y):
			spaces[i][j] = 1 # temporary, implement space first.
	
	# initialize spaces (right now this puts two rooks in A1/H8)
	pieces.resize(18)
	for i in pieces:
		i.resize(10)
		for j in range(i.size()):
			i[j] = null

func get_corners():
	pass

func set_pieces(value:Array[Array]) -> void:
	pieces = value

func get_pieces() -> Array[Array]:
	return pieces

func set_piece(piece_coordinate:Vector2i, value:PieceController) -> void:
	pieces[piece_coordinate.x][piece_coordinate.y] = value

func get_piece(piece_coordinate:Vector2i) -> PieceController:
	if(piece_coordinate.x < 0 or piece_coordinate.x >= 18):
		if(piece_coordinate.y < 0 or piece_coordinate.y >= 10):
			return null
	return pieces[piece_coordinate.x][piece_coordinate.y]

func set_spaces(value:Array[Array]) -> void:
	spaces = value

func get_spaces() -> Array[Array]:
	return spaces

func debug_toggled(value:bool) -> void:
	for i in get_spaces().size():
		for j in get_spaces()[i].size():
			get_spaces()[i][j].debug_toggled(value)

func clear_space_highlights() -> void:
	for i in spaces.size():
		for j in spaces[i].size():
			(spaces[i][j] as SpaceController).set_highlight(false)

func coordinate_moveable(value:Vector2i) -> bool:
	if value.x < 0 or value.x >= 18:
		return false
	if value.y < 0 or value.y >= 10:
		return false
	if not get_spaces()[value.x][value.y].get_enabled():
		return false
	if not (get_pieces()[value.x][value.y] == null):
		return false
	return true
	#for i in get_pieces().size():
		#for j in get_spaces()[i].size():
			#get_spaces()[i][j].debug_toggled(value)

func coordinate_capturable(source_coordinate:Vector2i, target_coordinate:Vector2i) -> bool:
	if target_coordinate.x < 0 or target_coordinate.x >= 18:
		return false
	if target_coordinate.y < 0 or target_coordinate.y >= 10:
		return false
	var source_piece = get_piece(source_coordinate)
	var target_piece = get_piece(target_coordinate)
	if source_piece and target_piece and source_piece.get_team() != target_piece.get_team():
		return true
	return false

# move or capture
func move_piece(source_coordinates:Vector2i, target_coordinates:Vector2i):
	var source_piece = get_piece(source_coordinates)
	var target_piece = get_piece(target_coordinates)
	if target_piece:
		target_piece.captured_by(source_piece)
	source_piece.set_coordinates(target_coordinates)
	set_piece(source_coordinates, null)
	set_piece(target_coordinates, source_piece)
