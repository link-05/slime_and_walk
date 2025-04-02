extends Node2D
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	#change_scene()
	if SceneControl.bottom:
		$player.position.x = SceneControl.player_enter_cliffside_posx
		$player.position.y = SceneControl.player_enter_cliffside_posy

# This is a singal that will allow scene transition to begin.
func _on_cliffside_exitpoint_body_entered(body):
	if body.has_method("player") and SceneControl.can_warp == true:
		global.scene_to_world();
		SceneControl.switch_scene("res://scenes/world.tscn")
		SceneControl.enterBottom()
		SceneControl.start_warp_protection()
		
	
	
	#if body.has_method("player"):
		#global.transition_scene = true
		
#func _on_cliffside_exitpoint_body_exited(body: Node2D) -> void:
	#if body.has_method("player"):
		#global.transition_scene = false
		#
#func change_scene():
	#if global.transition_scene == true:
		#if global.current_scene == "cliff_side":
			#get_tree().change_scene_to_file("res://scenes/world.tscn")
			#global.finish_changescenes_world_and_cliff_side()


 # Replace with function body.
