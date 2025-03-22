extends CharacterBody2D

#These are the base stats for the enemy,

# speed indicates enemy speed
var speed = 40

# player chase is off on default default, 
var player_chase = false

# player is the target and it is null on 
var player = null

# aiOn is the check for whether the behavior tree is active,
#    only on when not chasing player. 
var aiOn = false

# This is the max health of the enemy 
var health = 100

# This is the boolean that will signal if player is in the zone.  
var player_inattack_zone = false

# This determines if the enemy can take damage right now, to avoid
#   repeated damage value in a single strike. 
var can_take_damage = true

# These two methods are
#   The players damage dealing mechanic on the enemy 
#   The health bar of the enemy will continually be updated. 
func _physics_process(delta):
	deal_with_damage()
	update_health()
	
	# Once the player is in attack zone, the enemy will move towards the player.
	
	if player_chase:
		# The normalized is required - normalize movement to ensure diagonal motion 
		#   covers same distance as any other direction.
		position += (player.position - position).normalized() * speed * delta
		#animations
		$AnimatedSprite2D.play("walk")
		
		if(player.position.x - position.x < 0):
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
			
		#This will allow the enemy to move and collide with y sort objects.
		move_and_collide(Vector2(0,0))
	else:
		if aiOn:
			$AnimatedSprite2D.play("idle")
		
func _on_detection_area_body_entered(body):
	#To allow the enemy to chase the player.
	player = body
	player_chase = true

func _on_detection_area_body_exited(body):
	#Removes the chase target. 
	player = null
	player_chase = false
	
#This is a method that can allow other objects to check if it is the enemy.
func enemy():
	pass

#This is the smaller collision shape that on contact will damage the player
func _on_enemy_hitbox_body_entered(body):
	if body.has_method("player"):
		player_inattack_zone = true

#This is the smaller collision shape that will disable attacking the player
func _on_enemy_hitbox_body_exited(body):
	if body.has_method("player"):
		player_inattack_zone = false

#This is dealing damage to the enemy, the enemies damage dealing mechanism
#  is in the player node and not in the enemy node. 
func deal_with_damage():
	if player_inattack_zone and global.player_current_attack == true:
		if can_take_damage == true:
			health = health - 20
			#This is the timer that will reset the var can_take_damage
			$take_damage_cooldown.start()
			can_take_damage = false
			# For debug or test purpose. 
			#print("slime health = ", health)
			if health <= 0:
				self.queue_free()
				#To avoid player from taking ghost damage. 
				player.enemy_inattack_range = false

func _on_take_damage_cooldown_timeout():
	can_take_damage = true
	
func update_health():
	var healthbar = $healthbar
	
	healthbar.value = health
	if health > 100:
		healthbar.visible = false
	else:
		healthbar.visible = true

# This is for the behavior tree to move the enemy accurately.
# Helper methods are broken down into - Direction handling and Animation handling
func move(dirX, dirY, speed, distX, distY):
	if(not player_chase):
		aiOn = true
		#dist X Y determines if there are movement related to that axis.
		if not distX:
			velocity.x = dirX * speed
			flip(dirX)
		if not distY:
			velocity.y = dirY * speed
		handle_animation(dirX)
		move_and_slide()
		aiOn = false
			
func handle_animation(dirX):
	if(velocity.x != 0 or velocity.y != 0):
		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("idle")
		
func flip(dirX):
	if abs(dirX) == dirX:
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true
		
func play_idle():
	$AnimatedSprite2D.play("idle")
	
func check_for_self(node):
	if node == self:
		return true
	else:
		return false
	
