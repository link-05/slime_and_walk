extends Node2D

func _ready() -> void:
	#change_scene()
	if SceneControl.left:
		$player.position.x = SceneControl.player_leftenter_flatroad_posx
		$player.position.y = SceneControl.player_leftenter_flatroad_posy
	if SceneControl.right:
		$player.position.x = SceneControl.player_rightenter_flatroad_posx
		$player.position.y = SceneControl.player_rightenter_flatroad_posy
func _on_flatroad_exitpoint_body_entered(body: Node2D) -> void:
	if body.has_method("player") and SceneControl.can_warp == true:
		global.scene_to_world()
		SceneControl.start_warp_protection()
		SceneControl.switch_scene("res://scenes/world.tscn")
		SceneControl.enterRight()
		
func _on_flatroad_entrypoint_body_entered(body: Node2D) -> void:
	if body.has_method("player") and SceneControl.can_warp == true:
		global.scene_to_narrowpath()
		SceneControl.start_warp_protection()
		SceneControl.switch_scene("res://scenes/narrow_path.tscn")
		SceneControl.enterLeft()
