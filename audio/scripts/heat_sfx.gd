# A sound effect node that keeps the ear entertained
# 1. heat - same sounds that play within a few ms play at higher pitches
# 2. randomized - pitch is randomized around the target pitch within a range
extends Node

var player:AudioStreamPlayer

var sound_heat_map: Dictionary # {heat_sound_resource_name_string : float(0.0-1.0),..}
const HEAT_INCREMENT = 0.2
@export var heat_curve:Curve

func play(sound_resource:Resource) -> void:
	if sound_resource.resource_name not in sound_heat_map:
		sound_heat_map[sound_resource.resource_name] = 0.0
	
	
	var current_heat = sound_heat_map[sound_resource.resource_name]
	player.stream = sound_resource
	player.pitch_scale = 1.0 + heat_curve.sample(current_heat )
	player.play()
	
	sound_heat_map[sound_resource.resource_name] = clampf(current_heat+HEAT_INCREMENT,0.0,1.0)
	


func _ready() -> void:
	player = Globals.heat_sfx_player
	

func _process(delta: float) -> void:
	for i in sound_heat_map.keys():
		sound_heat_map[i] =clampf(sound_heat_map[i] - delta, 0.0, 1.0)
		if sound_heat_map[i] < 0:
			sound_heat_map.erase(i)
