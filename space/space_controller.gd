class_name SpaceController

extends Node
const SPACE_VIEW = preload("res://space/space_view.tscn")
@export var model: SpaceModel
@export var view: SpaceView

func initialize():
	model = SpaceModel.new()
	view = SPACE_VIEW.instantiate()
	add_child(view)
	view.owner = self
	view.initialize()

func set_enabled(value:bool) -> void:
	model.set_enabled(value)
	view.set_enabled(value)

func get_enabled() -> bool:
	return model.get_enabled()

func set_light(value:bool) -> void:
	model.set_light(value)
	view.set_light(value)

func get_light() -> bool:
	return model.get_light()

func set_coordinates(value:Vector2i) -> void:
	model.set_coordinates(value)
	view.set_coordinates(value)
	view.set_light((value.x + value.y) % 2 == 0)
	model.set_light((value.x + value.y) % 2 == 0)

func get_coordinates() -> Vector2i:
	return model.get_coordinates()

func set_highlight(value:bool) -> void:
	view.set_highlight(value)

func debug_toggled(value:bool) -> void:
	set_light(value)
