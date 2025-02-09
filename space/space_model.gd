# Implements state and gameplay related methods for a space
class_name SpaceModel
extends Resource

@export var enabled:bool = true
@export var is_light:bool = true
@export var coordinates:Vector2i = Vector2i(-1,-1)

func set_enabled(value:bool) -> void:
	enabled = value

func get_enabled() -> bool:
	return enabled

func set_light(value:bool) -> void:
	is_light = value

func get_light() -> bool:
	return is_light

func set_coordinates(value:Vector2i) -> void:
	coordinates = value

func get_coordinates() -> Vector2i:
	return coordinates
