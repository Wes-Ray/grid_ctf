extends Node


var red_bb = "[color=red]RED[/color]"
var blue_bb = "[color=blue]BLUE[/color]"


func _process(delta):
	
	if Input.is_action_just_pressed("move_left"):
		MP.requested_team = 0  # red
		$red.bbcode_text = "[b][u]" + red_bb + "[/u][/b]"
		$blue.bbcode_text = blue_bb
	elif Input.is_action_just_pressed("move_right"):
		MP.requested_team = 1  # blue
		$red.bbcode_text = red_bb
		$blue.bbcode_text = "[b][u]" + blue_bb + "[/u][/b]"


func _on_Button_pressed():
	
	if $ip_input.text.count(".") == 3:
		var x = $ip_input.text.split(".")
		MP.SERVER_IP = str(x[0] + "." + x[1] + "." + x[2] + "." + x[3])
		get_tree().change_scene("res://grid/grid.tscn")
	else:
		print("invalid ip")
