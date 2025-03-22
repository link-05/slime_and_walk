extends Node
var current_scene = null
var game_first_load = true

#positions for player location in world after leaving cliffside 
var player_exit_cliffside_posx = 200
var player_exit_cliffside_posy = 12
#positions for player spawn in world
var player_start_posx = 114
var player_start_posy = 109
#positions for player spawning in cliffside
var player_enter_cliffside_posx = 87
var player_enter_cliffside_posy = 136
#Grabs the current scene
func _ready() -> void:
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)

#Switch scene but call defer to allow everything to run before completing.	
func switch_scene(res_path):
	call_deferred("_deferred_switch_scene", res_path)
	
func _deferred_switch_scene(res_path):
	game_first_load = false
	current_scene.free()
	var s = load(res_path)
	current_scene = s.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
