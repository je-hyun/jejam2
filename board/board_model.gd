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

func set_pieces(value:Array[Array]) -> void:
	pieces = value

func get_pieces() -> Array[Array]:
	return pieces

func set_spaces(value:Array[Array]) -> void:
	spaces = value

func get_spaces() -> Array[Array]:
	return spaces

func debug_toggled(value:bool) -> void:
	for i in get_spaces().size():
		for j in get_spaces()[i].size():
			get_spaces()[i][j].debug_toggled(value)
	
	#for i in get_pieces().size():
		#for j in get_spaces()[i].size():
			#get_spaces()[i][j].debug_toggled(value)
