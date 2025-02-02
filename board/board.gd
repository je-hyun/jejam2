@tool
extends Control
const SPACE = preload("res://space/space.tscn")
@export var initialize_board:bool = false: set = _set_initialize_board

const SCREEN_WIDTH = 1800
const SCREEN_HEIGHT = 1000
const TILE_SIZE = 100

func _set_initialize_board(value:bool):
	assert(
		SCREEN_WIDTH == ProjectSettings.get_setting("display/window/size/viewport_width")
		and
		SCREEN_HEIGHT == ProjectSettings.get_setting("display/window/size/viewport_height")
	)
	for i in range(SCREEN_WIDTH/TILE_SIZE):
		for j in range(SCREEN_HEIGHT/TILE_SIZE):
			var instance = SPACE.instantiate()
			instance.name = "a"
			add_child(instance)
			instance.position = Vector2(i*TILE_SIZE, j*TILE_SIZE)
			instance.owner = get_tree().edited_scene_root
