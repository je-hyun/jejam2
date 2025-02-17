extends Node

const A1 = Vector2i(5,8)
const H8 = Vector2i(5+7,8-7)
const A8 = Vector2i(5+7,8)
const H1 = Vector2i(5,8-7)
var heat_sfx_player:AudioStreamPlayer = AudioStreamPlayer.new()
var board:BoardModel

func _ready() -> void:
	add_child(heat_sfx_player)
	heat_sfx_player.bus = "SFX"
	heat_sfx_player.max_polyphony = 50

func set_board(value:BoardModel):
	board = value
