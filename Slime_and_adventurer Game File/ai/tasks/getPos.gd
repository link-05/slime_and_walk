extends BTAction
# This is a behavior tree script that will find a random position 
@export var range_min_in_dir: float = 0
@export var range_max_in_dir: float = 60
@export var count: StringName = &"count" 
@export var pos_y: StringName = &"pos_y"
@export var pos_x: StringName = &"pos_x"
@export var dir_y: StringName = &"dir_y"
@export var dir_x: StringName = &"dir_x"

func _tick(_delta: float) -> Status:
	var pos_x1: Vector2
	var pos_y1: Vector2
	var dir_x = random_dirX()
	var dir_y = random_dirY()
	
	pos_x1 = random_posX(dir_x)
	pos_y1 = random_posY(dir_y)
	blackboard.set_var(pos_x, pos_x1)
	blackboard.set_var(pos_y, pos_y1)
	blackboard.set_var(count, 0)
	
	print(dir_x, dir_y, "| agent pos x: ", agent.global_position.x, "| agent pos y: ", agent.global_position.y)
	return SUCCESS
	
func random_posX(dir_x): 
	var vector: Vector2
	var distance_x = randi_range(range_min_in_dir, range_max_in_dir) * dir_x
	var final_position = (distance_x + agent.global_position.x)
	vector.x = final_position
	return vector
	
func random_posY(dir_y):
	var vector: Vector2
	var distance_y = randi_range(range_min_in_dir, range_max_in_dir) * dir_y
	var final_position = (distance_y + agent.global_position.y)
	vector.y = final_position
	return vector
	
func random_dirX():
	var dir_x1 = randi_range(-2, 1)
	if abs(dir_x1) != dir_x1:
		dir_x1 = -1
	else:
		dir_x1 = 1
	blackboard.set_var(dir_x, dir_x1)
	return dir_x1
	
func random_dirY():
	var dir_y1 = randi_range(-2, 1)
	if abs(dir_y1) != dir_y1:
		dir_y1 = -1
	else:
		dir_y1 = 1
	blackboard.set_var(dir_y, dir_y1)
	return dir_y1
