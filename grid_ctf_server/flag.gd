extends KinematicBody2D

# 0 = red, 1 = blue
func set_team(team_num : int) -> void:
	$red_flag.visible = false
	$blue_flag.visible = false
	
	if team_num == 0:  # red
		$red_flag.visible = true
	elif team_num == 1:  # blue
		$blue_flag.visible = true
