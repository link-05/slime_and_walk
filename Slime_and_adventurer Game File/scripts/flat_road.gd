extends Node2D

func _ready() -> void:
	#change_scene()
	$player.position.x = SceneControl.player_leftenter_flatroad_posx
	$player.position.y = SceneControl.player_leftenter_flatroad_posy

func _on_flatroad_exitpoint_body_entered(body: Node2D) -> void:
	if body.has_method("player") and SceneControl.can_warp == true:
		SceneControl.start_warp_protection()
		SceneControl.switch_scene("res://scenes/narrow_path.tscn")
	
func _on_flatroad_entrypoint_body_entered(body: Node2D) -> void:
	if body.has_method("player") and SceneControl.can_warp == true:
		SceneControl.start_warp_protection()
		SceneControl.switch_scene("res://scenes/world.tscn")
