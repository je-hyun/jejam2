# Exposes methods to interact with a single piece. Contains a PieceModel and PieceView.
class_name PieceController
extends Node

# These signals correspond to piece_view.dragged / dropped signals,
# BUT thesee also add a source controller. The source it returns is self.
signal try_drag(piece_controller:PieceController)
signal try_drop(piece_controller:PieceController, target_space:Vector2i)
const PIECE_VIEW = preload("res://piece/piece_view.tscn")
@export var model: PieceModel
@export var view: PieceView

func initialize_piece():
	model = PieceModel.new()
	view = PIECE_VIEW.instantiate()
	add_child(view)
	view.owner = self
	view.initialize_piece_view()
	
	assert(owner is Main, "Owner (%s) should be main (signal connections made based on that assumption)" % owner)
	try_drag.connect(owner._try_drag)
	try_drop.connect(owner._try_drop)

func set_base_piece(value:Enums.BasePieces):
	model.base_piece = value
	view.base_piece = value

func set_coordinates(value:Vector2i):
	model.coordinates = value
	view.set_coordinates(value)

func get_coordinates() -> Vector2i:
	return model.coordinates

func _try_drag() -> void:
	print("try dragged")
	try_drag.emit(self)

func _try_drop(target_space:Vector2i) -> void:
	print("try dropped")
	try_drop.emit(self, target_space)

func drag() -> void:
	view.set_dragging(true)

func drop(target_coordinates:Vector2i) -> void:
	view.set_dragging(false)
	view.set_coordinates(target_coordinates)
	if target_coordinates != model.get_coordinates():
		model.set_coordinates(target_coordinates)

func get_legal_moves(board: BoardModel) -> Array[Vector2i]:
	return model.get_legal_moves(board)
