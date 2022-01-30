extends KinematicBody2D

export var RED_TEAM_COLOR := Color()
export var BLUE_TEAM_COLOR := Color()
export var GRAY_TEAM_COLOR := Color()

var team_num = -1
var is_alive = true


func update_color() -> void:
	var new_color
	
	if team_num == 0:  # 0 = red team
		new_color = RED_TEAM_COLOR
	elif team_num == 1:  # 1 = blue team
		new_color = BLUE_TEAM_COLOR
	else:
		new_color = GRAY_TEAM_COLOR
	
	$icon.modulate = new_color
	
	if is_alive == false:
		$icon.modulate.a = 0.5


# update color of player to be a ghost if dead, back to team color if alive
func set_alive(alive_bool : bool) -> void:
	is_alive = alive_bool
	update_color()


func update_team_color(new_team_num : int) -> void:
	team_num = new_team_num
	update_color()

