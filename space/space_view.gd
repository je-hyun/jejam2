class_name SpaceView
extends Control
enum CORNER {MIDDLE, TOP_LEFT, TOP_RIGHT, BOTTOM_LEFT, BOTTOM_RIGHT}
@export var is_light:bool = true : set = _set_is_light
@export var enabled:bool = true : set = set_enabled
@export var corner:CORNER = CORNER.MIDDLE: set = _set_corner

const SPACE = preload("res://space/space.png")
const DARK_COLOR:Color = Color("2b3634")
const LIGHT_COLOR:Color = Color("a2856c")
var coordinates:Vector2i = Vector2i(-1,-1)


@export var rank:String = "?" :
	set(value):
		rank = value
		%rank_label.text = value

@export var file:String = "?" :
	set(value):
		file = value
		%file_label.text = value

func initialize():
	pass

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

func set_highlight(value:bool) -> void:
	%highlight.visible = value

func _ready() -> void:
	if Engine.is_editor_hint():
		# Code to execute when in editor.
		pass
	if not Engine.is_editor_hint():
		_set_is_light(is_light)

func _on_graphic_mouse_entered() -> void:
	if not Engine.is_editor_hint():
		%animation.play("text_fade_in")

func _on_graphic_mouse_exited() -> void:
	if not Engine.is_editor_hint():
		%animation.play("text_fade_out")

func set_enabled(value:bool) -> void:
	enabled = value
	if value:
		modulate.a = 1.0
	else:
		modulate.a = 0.0

func set_light(value:bool) -> void:
	is_light = value

func get_light() -> bool:
	return is_light

func set_coordinates(value: Vector2i):
	set_global_position( _coordinates_to_position(value))
	coordinates = value
	%file_label.text = "file:%d" % value.x
	%rank_label.text = "rank:%d" % value.y

func _snap_position(coordinate: Vector2, snap_amount:int=100) -> Vector2:
	return Vector2(
		clamp(int(coordinate.x)/snap_amount*snap_amount,0,1800), clamp(int(coordinate.y)/snap_amount*snap_amount,0,1000)
	)

func _position_to_coordinates(_position:Vector2) -> Vector2i:
	var result:Vector2i = Vector2i(
		clamp(int(_position.x/100),0,18), clamp(int(_position.y/100),0,10)
	)
	return result

func _coordinates_to_position(coordinate:Vector2i) -> Vector2:
	var result:Vector2 = Vector2(
		100 * coordinate.x,
		100 * coordinate.y
	)
	return result
