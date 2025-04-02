extends Node2D
#The world node is the starting scene.

# This will make sure the player is at the right position when they load
#  in from the top area, right area or game start. 
func _ready():
	if SceneControl.game_first_load == true:
		$player.position.x = SceneControl.player_start_posx
		$player.position.y = SceneControl.player_start_posy
	elif SceneControl.top:
		$player.position.x = SceneControl.player_exit_cliffside_posx
		$player.position.y = SceneControl.player_exit_cliffside_posy
	elif SceneControl.right:
		$player.position.x = SceneControl.player_enter_world_from_narrowpath_posx
		$player.position.y = SceneControl.player_enter_world_from_narrowpath_posy


#Checks if the scene changes. 
func _process(delta):
	#change_scene()
	pass

#When the area2d of cliffside is contacted by a player node then it will
#  allow the global scene to call the transition. 
func _on_cliffside_transition_point_body_entered(body: Node2D) -> void:
	if body.has_method("player") and SceneControl.can_warp == true:
		#global.transition_scene = true 
		#Checks if the node is a player node through a method known as player
		# and allow the transition from cliffside to the world to occur
		#global.finish_changescenes_world_and_cliff_side()
		global.scene_to_cliffside();
		SceneControl.switch_scene("res://scenes/cliff_side.tscn")
		SceneControl.enterTop()
		SceneControl.start_warp_protection()


#remove later - this is first version with only one scene change
#func _on_cliffside_transition_point_body_exited(body: Node2D) -> void:
	#if body.has_method("player"):
		#print("Exited Collision Zone")
		#global.transition_scene = false

#func change_scene():
	#if global.transition_scene == true:
		#if global.current_scene == "world":
			#get_tree().change_scene_to_file("res://scenes/cliff_side.tscn")
			#global.game_first_loadin = false
			#global.finish_changescenes_world_and_cliff_side()

func _on_narrow_path_transition_point_body_entered(body: Node2D) -> void:
	if body.has_method("player") and SceneControl.can_warp == true:
		global.scene_to_narrowpath();
		SceneControl.switch_scene("res://scenes/narrow_path.tscn")
		SceneControl.enterRight()
		SceneControl.start_warp_protection()
