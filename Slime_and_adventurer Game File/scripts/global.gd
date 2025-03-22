extends Node
# This is the global variable that is in charge of scene changes and player
var player_current_attack = false

var current_scene = "world" #world cliff_side

#func finish_changescenes_world_and_cliff_side():
	#if transition_scene == true:
		#if current_scene == "world":
			##get_tree().change_scene_to_file("res://scenes/cliff_side.tscn")
			##Global.game_first_loadin = false
			#current_scene = "cliffside"
		#elif current_scene == "cliffside":
			##get_tree().change_scene_to_file("res://scenes/world.tscn")
			##Global.game_first_loadin = false
			#current_scene = "world"
			#
#func finish_changescenes_world_and_flat_road():
	#if transition_scene == true:
		#transition_scene = false
		#if current_scene == "world":
			#current_scene = "flat_road"
		#else:
			#current_scene = "world"
			#
#func finish_changescenes_flat_road_and_narrow_path():
	#if transition_scene == true:
		#transition_scene = false
		#if current_scene == "world":
			#current_scene = "flat_road"
		#else:
			#current_scene = "world"
