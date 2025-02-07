extends Control

var board_spaces: Array[Array] # board spaces
@onready var board: Control = $board

var dragging_piece:Piece

func piece_dragged(piece:Piece):
	print(piece.to_string() + " is being dragged")

func piece_dropped(piece:Piece):
	print(piece.to_string() + " is being dropped")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
