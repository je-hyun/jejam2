@tool
class_name Space
extends Control
enum CORNER {MIDDLE, TOP_LEFT, TOP_RIGHT, BOTTOM_LEFT, BOTTOM_RIGHT}
@export var is_light:bool = true : set = _set_is_light
@export var enabled:bool = true : set = _set_enabled
@export var corner:CORNER = CORNER.MIDDLE: set = _set_corner
const SPACE = preload("res://space/space.png")
const SPACE_CORNER = preload("res://space/space-corner.png")
const DARK_COLOR:Color = Color("2b3634")
const LIGHT_COLOR:Color = Color("a2856c")

@export var rank:String = "?" :
	set(value):
		rank = value
		%rank_label.text = value

@export var file:String = "?" :
	set(value):
		file = value
		%file_label.text = value

func _set_corner(value:CORNER):
	corner = value
	%graphic.material.set("shader_parameter/topleft_radius", 0.0)
	%graphic.material.set("shader_parameter/topright_radius", 0.0)
	%graphic.material.set("shader_parameter/bottomleft_radius", 0.0)
	%graphic.material.set("shader_parameter/bottomright_radius", 0.0)
	match value:
		CORNER.TOP_LEFT:
			%graphic.material.set("shader_parameter/topleft_radius", 0.1)
		CORNER.TOP_RIGHT:
			%graphic.material.set("shader_parameter/topright_radius", 0.1)
		CORNER.BOTTOM_LEFT:
			%graphic.material.set("shader_parameter/bottomleft_radius", 0.1)
		CORNER.BOTTOM_RIGHT:
			%graphic.material.set("shader_parameter/bottomright_radius", 0.1)

func _set_is_light(value:bool):
	is_light = value
	if value:
		%graphic.modulate = LIGHT_COLOR
		%rank_label.modulate = DARK_COLOR
		%file_label.modulate = DARK_COLOR
	else:
		%graphic.modulate = DARK_COLOR
		%rank_label.modulate = LIGHT_COLOR
		%file_label.modulate = LIGHT_COLOR

func _set_enabled(value:bool):
	# Code to execute when in editor.
	enabled = value
	if value:
		modulate.a = 1.0
	else:
		modulate.a = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Engine.is_editor_hint():
		# Code to execute when in editor.
		pass
	if not Engine.is_editor_hint():
		_set_is_light(is_light)
	

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
		%animation.play("text_fade_in")


func _on_graphic_mouse_exited() -> void:
	if not Engine.is_editor_hint():
		%animation.play("text_fade_out")
