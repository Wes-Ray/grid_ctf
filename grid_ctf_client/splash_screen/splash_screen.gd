extends Node


func _ready():
	pass
	#get_tree().change_scene("res://grid/grid.tscn")


func _process(delta):
	if Input.is_action_just_pressed("ui_select"):
		print("sending test func call")
		rpc("test")
