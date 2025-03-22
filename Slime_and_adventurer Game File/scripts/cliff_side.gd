extends Node2D
# first load is to give a buffer from when the place first enter into the area to prevent automatically changing back scene again.
var first_load = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	#change_scene()
	$player.position.x = SceneControl.player_enter_cliffside_posx
	$player.position.y = SceneControl.player_enter_cliffside_posy

# This is a singal that will allow scene transition to begin.
func _on_cliffside_exitpoint_body_entered(body):
	if not first_load:
		SceneControl.switch_scene("res://scenes/world.tscn")
	first_load = false		
	
	
	
	
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
