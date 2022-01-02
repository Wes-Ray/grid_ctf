extends KinematicBody2D

export var color := Color(0.18, 0.18, 0.78, 1)
#export var coords := Vector2(-1, -1)  # coordinates for player position


func _ready():
	update_color(color)


func update_color(new_color : Color):
	$icon.modulate = new_color
