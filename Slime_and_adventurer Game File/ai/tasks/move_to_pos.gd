extends BTAction

@export var target_posX := &"pos_x"
@export var target_posY := &"pos_y"
@export var dirX := &"dir_x"
@export var dirY := &"dir_y"
@export var count := &"count"
@export var speed_var = 40
@export var tolerance = 10

func _tick(_delta: float) -> Status:
	var target_posX: Vector2 = blackboard.get_var(target_posX, Vector2.ZERO)
	var target_posY: Vector2 = blackboard.get_var(target_posY, Vector2.ZERO)
	var dirX = blackboard.get_var(dirX)
	var dirY = blackboard.get_var(dirY)
	var distX = (abs(agent.global_position.x - target_posX.x) < tolerance)
	var distY = (abs(agent.global_position.y - target_posY.y) < tolerance)
	var count = blackboard.get_var(count)
	if count == 30:
		agent.play_idle()
		return SUCCESS
	
	if distX and distY:
		agent.move(dirX, dirY, 0, distX, distY)
		return SUCCESS
	else:
		agent.move(dirX, dirY, speed_var, distX, distY)
		blackboard.set_var(&"count", count + 1)
		return RUNNING
