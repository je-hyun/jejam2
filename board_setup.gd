@tool
extends EditorScript

const SPACE = preload("res://space/space.tscn")
const SCREEN_WIDTH = 1800
const SCREEN_HEIGHT = 1000
const TILE_SIZE = 100
const FILE_LABELS = ['-e','-d','-c','-b','-a','a','b','c','d','e','f','g','h','i','j','k','l','m']
const RANK_LABELS = ['9','8','7','6','5','4','3','2','1','0']

var board_spaces: Array[Array]

# Called when the script is executed (using File -> Run in Script Editor).
func _run() -> void:
	assert(get_scene().name == "main", "Script should only be called from main.")
	var board = get_scene().get_node_or_null("%board")
	initialize_board(board)

func initialize_board(board_node:Node):
	for n in board_node.get_children():
		board_node.remove_child(n)
		n.queue_free()
	assert(
		SCREEN_WIDTH == ProjectSettings.get_setting("display/window/size/viewport_width")
		and
		SCREEN_HEIGHT == ProjectSettings.get_setting("display/window/size/viewport_height"),
		"The screen width in board.gd must match project settings."
	)
	var ranks:int = SCREEN_HEIGHT/TILE_SIZE
	var files:int = SCREEN_WIDTH/TILE_SIZE
	for r in range(ranks):
		for f in range(files):
			var instance = SPACE.instantiate()
			if (f < 5 or f >= files - 5 or r < 1 or r  >= ranks - 1):
				instance.enabled = false
			if (f % 2 == 0 and r % 2 == 0) or (f % 2 == 1 and r % 2 == 1):
				instance.is_light = true
			else:
				instance.is_light = false
			instance.name = FILE_LABELS[f] + RANK_LABELS[r]
			instance.rank = RANK_LABELS[r]
			instance.file = FILE_LABELS[f]
			
			
			board_node.add_child(instance)
			instance.position = Vector2(f*TILE_SIZE, r*TILE_SIZE)
			instance.owner = board_node.get_tree().edited_scene_root
			if instance.name == "a1":
				instance.corner = Space.CORNER.BOTTOM_LEFT
			if instance.name == "h1":
				instance.corner = Space.CORNER.BOTTOM_RIGHT
			if instance.name == "a8":
				instance.corner = Space.CORNER.TOP_LEFT
			if instance.name == "h8":
				instance.corner = Space.CORNER.TOP_RIGHT
