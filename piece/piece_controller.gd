# Exposes methods to interact with a single piece. Contains a PieceModel and PieceView.
class_name PieceController
extends Node

# These signals correspond to piece_view.dragged / dropped signals,
# BUT thesee also add a source controller. The source it returns is self.
signal piece_dragged(piece_controller:PieceController)
signal piece_dropped(piece_controller:PieceController, target_space:Vector2i)

@export var model: PieceModel
@export var view: PieceView

func set_base_piece(value:Enums.BasePieces):
	model.base_piece = value
	view.base_piece = value

func set_position(value:Vector2i):
	model.coordinates = value
	view.set_coordinates(value)

func _piece_dragged() -> void:
	print("dragged")
	piece_dragged.emit(self)

func _piece_dropped(target_space:Vector2i) -> void:
	print("dropped")
	piece_dropped.emit(self, target_space)

func _ready() -> void:
	pass
