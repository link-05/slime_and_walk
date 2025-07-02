extends Node
var current_scene = null
var game_first_load = true
var can_warp = true
var warp_cooldown_timer = Timer.new()
# these indicate the direction that the player came from
# top being true would mean player spawn at a bottom location
var top = false
var bottom = false
var right = false
var left = false

#World Specific spawn positions 
#positions for player spawn in world
var player_start_posx = 114
var player_start_posy = 109
#positions for player spawn in world from flatroad
var player_world_left_posx = 4
var player_world_left_posy = 33
#positions for player location in world after leaving cliffside 
var player_exit_cliffside_posx = 200
var player_exit_cliffside_posy = 12
#positions for spawn in world from narrow path 
var player_enter_world_from_narrowpath_posx = 408
var player_enter_world_from_narrowpath_posy = 105

#Cliffside specific spawn positions 
#positions for player spawning in cliffside
var player_enter_cliffside_posx = 87
var player_enter_cliffside_posy = 136

#Narrowpath specific spawn positions. 
#positions for player to spawn in narrowpath from world
var player_leftenter_narrowpath_posx = 385
var player_leftenter_narrowpath_posy = 386
#positions for player to spawn in narrowpath from flatroad
var player_rightenter_narrowpath_posx = 1257
var player_rightenter_narrowpath_posy = 392

#Flatroad specific spawn positions
#positions for player to spawn in flatroad from narrowroad
var player_leftenter_flatroad_posx = 385
var player_leftenter_flatroad_posy = 388
#positions for player to spawn in flatroad from world
var player_rightenter_flatroad_posx = 1273
var player_rightenter_flatroad_posy = 385


#Grabs the current scene
func _ready() -> void:
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	warp_cooldown_timer.autostart = true
	#warp_cooldown_timer.connect("timeout", warp_cooldown_timer, _on_warp_cooldown_timeout())
	#add_child(warp_cooldown_timer)

#Switch scene but call defer to allow everything to run before completing.	
func switch_scene(res_path):
	call_deferred("_deferred_switch_scene", res_path)
#This will get rid of the current scene,
#  load the new scene first before finally swapping out the actual scene
func _deferred_switch_scene(res_path):
	game_first_load = false
	current_scene.free()
	var s = load(res_path)
	current_scene = s.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
	
#Will not allow player to warp until time is over
func start_warp_protection() -> void:
	#step 1: disable warp
	can_warp = false
	#step 2: start timer
	await get_tree().create_timer(0.1).timeout
	can_warp = true
	#warp_cooldown_timer.start(1.5)

#Will allow player to warp again after cooldown
#func _on_warp_cooldown_timeout():
	#can_warp = true

func enterLeft() -> void:
	left = false
	right = true
	top = false
	bottom = false
func enterRight() -> void:
	left = true
	right = false
	top = false
	bottom = false
func enterTop() -> void:
	left = false
	right = false
	top = false
	bottom = true
func enterBottom() -> void:
	left = false
	right = false
	top = true
	bottom = false
