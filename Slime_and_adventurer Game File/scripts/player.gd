extends CharacterBody2D

var enemy_inattack_range = false
var enemy_attack_cooldown = true
var health = 100
var player_alive = true
var attack_ip = false
var main_sm = LimboHSM
var camera_sm = LimboHSM

const speed = 100
var current_dir = "none";

func _ready():
	if global.current_scene == "cliff_side":
		$AnimatedSprite2D.play("back_idle")
	elif global.current_scene == "world":
		$AnimatedSprite2D.play("front_idle")
	initiate_state_machine()
func _physics_process(delta):
	player_movement(delta)
	enemy_attack()
	current_camera()
	update_health()
	
	if health <= 0:
		player_alive = false #go back to menu or respawn
		health = 0
		print("player has been killed")
		self.queue_free()
func initiate_state_machine():
	main_sm = LimboHSM.new()
	add_child(main_sm)
	var idle_state = LimboState.new().named("idle").call_on_enter(idle_start).call_on_update(idle_update)
	var walk_state = LimboState.new().named("walk").call_on_enter(walk_start).call_on_update(walk_update)
	var attack_state = LimboState.new().named("attack").call_on_enter(attack_start).call_on_update(attack_update)
	
	var world_scene_state = LimboState.new().named("worldCM").call_on_enter(worldCM_start).call_on_update(worldCM_update)
	# Main sm is for player movement
	main_sm.add_child(idle_state)
	main_sm.add_child(walk_state)
	main_sm.add_child(attack_state)
	
	main_sm.initial_state = idle_state
	
	main_sm.add_transition(main_sm.ANYSTATE, idle_state, &"state_ended")
	main_sm.add_transition(idle_state, walk_state, &"to_walk")
	main_sm.add_transition(main_sm.ANYSTATE, attack_state, &"to_attack")
	main_sm.initialize(self)
	main_sm.set_active(true)
	
	# camera_sm 	
	camera_sm = LimboHSM.new()
	add_child(camera_sm)
	var world_state =  LimboState.new().named("worldCM").call_on_enter(worldCM_start).call_on_update(worldCM_update)
	camera_sm.add_child(world_state)
func player_movement(delta):
	if Input.is_action_pressed("attack"):
		main_sm.dispatch(&"to_attack")
	if Input.is_action_pressed("ui_right"):
		current_dir = "right"
		velocity.x = speed
		velocity.y = 0
		main_sm.dispatch(&"to_walk")
	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		velocity.x = -speed
		velocity.y = 0
		main_sm.dispatch(&"to_walk")
	elif Input.is_action_pressed("ui_down"):
		current_dir = "down"
		velocity.y = speed
		velocity.x = 0
		main_sm.dispatch(&"to_walk")
	elif Input.is_action_pressed("ui_up"):
		current_dir = "up"
		velocity.y = -speed
		velocity.x = 0
		main_sm.dispatch(&"to_walk")
	else:
		velocity.x = 0
		velocity.y = 0
	move_and_slide()	
func player():
	pass
func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_inattack_range = true
func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_inattack_range = false	
func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown == true:
		health = health - 10
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print(health)
func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true
func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	global.player_current_attack = false
	attack_ip = false
func current_camera():
	if global.current_scene == "world":
		$world_camera.enabled = true
		$cliffside_camera.enabled = false
		$flat_road_camera.enabled = false
		$narrow_path_camera.enabled == false
	elif global.current_scene == "cliff_side":
		$world_camera.enabled = false
		$cliffside_camera.enabled = true
		$flat_road_camera.enabled = false
		$narrow_path_camera.enabled == false
	elif global.current_scene == "flat_road":
		$world_camera.enabled = false
		$cliffside_camera.enabled = false
		$flat_road_camera.enabled = true
		$narrow_path_camera.enabled == false
	elif global.current_scene == "narrow_path":
		$world_camera.enabled = false
		$cliffside_camera.enabled = false
		$flat_road_camera.enabled = false
		$narrow_path_camera.enabled == true
func update_health():
	var healthbar = $healthbar
	
	healthbar.value = health
	
	if health >= 100:
		healthbar.visible = false
	else: 
		healthbar.visible = true
func _on_regen_timer_timeout() -> void:
	if health < 100:
		health = health + 20
		if health > 100:
			health = 100
	if health <= 0:
		health = 0
func idle_start():
	pass	
func idle_update(delta: float):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	if velocity.x != 0 or velocity.y != 0:
		main_sm.dispatch(&"to_walk")
	if not attack_ip:
		if dir == "right":
			anim.flip_h = false
			if velocity.x == 0:
				anim.play("side_idle")
		if dir == "left":
			anim.flip_h = true
			if velocity.x == 0:
				anim.play("side_idle")
		if dir == "down":
			anim.flip_h = true
			if velocity.y == 0:
				anim.play("front_idle")
		if dir == "up":
			anim.flip_h = true
			if velocity.y == 0:
				anim.play("back_idle")
	main_sm.dispatch(&"state_ended")
func walk_start():
	pass
func walk_update(delta: float):
	var dir = current_dir
	var anim = $AnimatedSprite2D

	if dir == "right":
		anim.flip_h = false
		anim.play("side_walk")
	if dir == "left":
		anim.flip_h = true
		anim.play("side_walk")
	if dir == "down":
		anim.flip_h = true
		anim.play("front_walk")
	if dir == "up":
		anim.flip_h = true
		anim.play("back_walk")
	main_sm.dispatch(&"state_ended")
func attack_start():
	pass
func attack_update(delta: float):
	var dir = current_dir
	if Input.is_action_just_pressed("attack"):
		global.player_current_attack = true
		attack_ip = true
		if dir == "right":
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("side_attack")
			$deal_attack_timer.start()
		if dir == "left":
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("side_attack")
			$deal_attack_timer.start()
		if dir == "down":
			$AnimatedSprite2D.play("front_attack")
			$deal_attack_timer.start()
		if dir == "up":
			$AnimatedSprite2D.play("back_attack")
			$deal_attack_timer.start()
	main_sm.dispatch(&"state_ended")
func worldCM_start(delta: float):
	$world_camera.enabled = true
	$cliffside_camera.enabled = false
	$flat_road_camera.enabled = false
	$narrow_path_camera.enabled = false
func worldCM_update(delta: float):
	if not (global.current_scene == "World"):
		camera_sm.dispatch(&"update_camera_state")
	
	
