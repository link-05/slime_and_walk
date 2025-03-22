extends BTAction

@export var target_var := &"target"

@export var speed_var = 60
@export var tolerance = 20 

func _tick(_delta: float ) -> Status: 
	var target: CharacterBody2D = blackboard.get_var(target_var)
	if target != null:
		var target_positionX = target.global_position.x
		var target_positionY = target.global_position.y
		var dirX = agent.global_position.direction_to(target_positionX)
		var dirY = agent.global_position.direction_to(target_positionY)
		#
		#if abs(agent.global_position.x - target_positionX) < tolerance:
			#agent.move(dir.x, dir.y, 0, false, false)
			#return SUCCESS
		#else:
		agent.move(dirX, dirY, speed_var, false, false)
		return SUCCESS
	return FAILURE
