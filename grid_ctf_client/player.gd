extends KinematicBody2D

export var RED_TEAM_COLOR := Color()
export var BLUE_TEAM_COLOR := Color()
export var GRAY_TEAM_COLOR := Color()


func update_color(new_color : Color):
	$icon.modulate = new_color

func update_team_color(team_num : int):
	if team_num == 0:  # 0 = red team
		update_color(RED_TEAM_COLOR)
	elif team_num == 1:  # 1 = blue team
		update_color(BLUE_TEAM_COLOR)
	else:
		update_color(GRAY_TEAM_COLOR)
