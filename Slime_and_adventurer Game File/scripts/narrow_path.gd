extends Node2D

func _ready() -> void:
	#change_scenes
	if SceneControl.left:
		$player.position.x = SceneControl.player_leftenter_narrowpath_posx
		$player.position.y = SceneControl.player_leftenter_narrowpath_posy
	elif SceneControl.right:
		$player.position.x = SceneControl.player_rightenter_narrowpath_posx
		$player.position.y = SceneControl.player_rightenter_narrowpath_posy
func _on_narrow_path_exitpoint_left_body_entered(body: Node2D) -> void:
	if body.has_method("player") and SceneControl.can_warp == true:
		global.scene_to_world();
		SceneControl.start_warp_protection()
		SceneControl.switch_scene("res://scenes/world.tscn")
		SceneControl.enterLeft()
		
func _on_narrow_path_exitpoint_right_body_entered(body: Node2D) -> void:
	if body.has_method("player") and SceneControl.can_warp == true:
		global.scene_to_flatroad();
		SceneControl.start_warp_protection()
		SceneControl.switch_scene("res://scenes/flat_road.tscn")
		SceneControl.enterLeft()
		
