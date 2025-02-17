# Exposes methods to interact with a single piece. Contains a PieceModel and PieceView.
class_name PieceController
extends Node

# These signals correspond to piece_view.dragged / dropped signals,
# BUT thesee also add a source controller. The source it returns is self.
signal try_drag(piece_controller:PieceController)
signal try_drop(piece_controller:PieceController, target_space:Vector2i)
signal captured(source:PieceController, target:PieceController)

const PIECE_VIEW = preload("res://piece/piece_view.tscn")
@export var model: PieceModel
@export var view: PieceView
var _base_piece: iBasePiece

func initialize_piece(_base_piece:iBasePiece):
	model = PieceModel.new()
	view = PIECE_VIEW.instantiate()
	add_child(view)
	view.owner = self
	view.initialize_piece_view()
	set_base_piece(_base_piece)

	assert(owner is Main, "Owner (%s) should be main (signal connections made based on that assumption)" % owner)
	try_drag.connect(owner._try_drag)
	try_drop.connect(owner._try_drop)
	captured.connect(owner._captured)
	model.connect("coordinates_moved", _on_model_coordinates_moved)
	model.connect("captured", _on_captured)


func set_base_piece(value:iBasePiece):
	model.set_base_piece(value)
	view.set_base_piece(value)

func set_coordinates(value:Vector2i):
	model.set_coordinates(value)
	
func _on_model_coordinates_moved(value:Vector2i):
	view.set_coordinates(value)

func get_coordinates() -> Vector2i:
	return model.coordinates

func captured_by(source_piece:PieceController) -> void:
	model.captured_by(source_piece)

func _on_captured(source:PieceController) -> void:
	captured.emit(source, self)

func _try_drag() -> void:
	try_drag.emit(self)

func _try_drop(target_space:Vector2i) -> void:
	try_drop.emit(self, target_space)

func drag() -> void:
	view.set_dragging(true)

func drop(target_coordinates:Vector2i) -> void:
	model.set_coordinates(target_coordinates)

func get_legal_moves(board: BoardModel) -> Array[Vector2i]:
	return model.get_legal_moves(board)

func set_team(value:Enums.Teams):
	model.set_team(value)
	view.set_team(value)

func get_team() -> Enums.Teams:
	return model.get_team()
