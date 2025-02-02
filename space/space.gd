@tool
extends Control
enum CORNER {MIDDLE, TOP_LEFT, TOP_RIGHT, BOTTOM_LEFT, BOTTOM_RIGHT}
@export var is_light:bool = true : set = _set_is_light
@export var enabled:bool = true : set = _set_enabled
@export var corner:CORNER = CORNER.MIDDLE: set = _set_corner
const SPACE = preload("res://space/space.png")
const SPACE_CORNER = preload("res://space/space-corner.png")
const DARK_COLOR:Color = Color("739552")
const LIGHT_COLOR:Color = Color("ebecd0")

func _set_corner(value:CORNER):
	corner = value
	if value == CORNER.MIDDLE:
		%graphic.texture = SPACE
	else:
		%graphic.texture = SPACE_CORNER
	match value:
		CORNER.MIDDLE:
			%graphic.rotation_degrees = 0
		CORNER.TOP_LEFT:
			%graphic.rotation_degrees = 0
		CORNER.TOP_RIGHT:
			%graphic.rotation_degrees = 90
		CORNER.BOTTOM_LEFT:
			%graphic.rotation_degrees = 270
		CORNER.BOTTOM_RIGHT:
			%graphic.rotation_degrees = 180

func _set_is_light(value:bool):
	# Code to execute when in editor.
	is_light = value
	if value:
		%graphic.modulate = LIGHT_COLOR
	else:
		%graphic.modulate = DARK_COLOR

func _set_enabled(value:bool):
	# Code to execute when in editor.
	enabled = value
	if value:
		modulate.a = 0.0
	else:
		modulate.a = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Engine.is_editor_hint():
		# Code to execute when in editor.
		pass
	if not Engine.is_editor_hint():
		# Code to execute when in game.
		pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		# Code to execute when in editor.
		pass
	if not Engine.is_editor_hint():
		# Code to execute when in game.
		pass


func _on_graphic_mouse_entered() -> void:
	if not Engine.is_editor_hint():
		pass


func _on_graphic_mouse_exited() -> void:
	if not Engine.is_editor_hint():
		pass
