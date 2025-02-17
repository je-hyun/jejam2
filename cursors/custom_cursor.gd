extends Control
const CURSOR_NONE = preload("res://cursors/cursor_none.png")
const HAND_CLOSED = preload("res://cursors/hand_closed.png")
const HAND_OPEN = preload("res://cursors/hand_open.png")
const HAND_POINT = preload("res://cursors/hand_point.png")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_custom_mouse_cursor(
		CURSOR_NONE, Input.CURSOR_ARROW, Vector2(8, 4)
		)
	Input.set_custom_mouse_cursor(
		HAND_OPEN, Input.CURSOR_POINTING_HAND, Vector2(8, 4)
		)
	Input.set_custom_mouse_cursor(
		HAND_CLOSED, Input.CURSOR_DRAG, Vector2(8, 4)
		)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
