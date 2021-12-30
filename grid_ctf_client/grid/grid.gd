extends Node2D

var cell_res = load("res://grid/grid_cell.png")

var CELL_WIDTH := 32
var GRID_WIDTH := 28
var GRID_HEIGHT := 16

onready var origin := get_node("origin")
onready var player := get_node("origin/player")
var player_cell_pos := Vector2.ZERO  # used to locate player on grid, not graphics position

func _ready():
	generate_map()


func _process(delta):
	# get new player_cell_pos 
	if Input.is_action_just_pressed("ui_right"):
		move_player(Vector2.RIGHT)
	elif Input.is_action_just_pressed("ui_left"):
		move_player(Vector2.LEFT)
	elif Input.is_action_just_pressed("ui_up"):
		move_player(Vector2.UP)
	elif Input.is_action_just_pressed("ui_down"):
		move_player(Vector2.DOWN)
	
	# update grid reflection of player_cell_pos
	player.position = (player_cell_pos * CELL_WIDTH) + origin.position


func move_player(dir : Vector2) -> void:
	# clamp cell_pos to grid_width and height
	var new_pos = player_cell_pos + dir
	var new_x = clamp(new_pos.x, 0, GRID_WIDTH-1)
	var new_y = clamp(new_pos.y, 0, GRID_HEIGHT-1)
	player_cell_pos = Vector2(new_x, new_y)


func generate_map() -> void:
	var cell_sprite = Sprite.new()
	cell_sprite.texture = cell_res
	cell_sprite.centered = false
	
	for x in range(GRID_WIDTH):
		for y in range(GRID_HEIGHT):
			var new_cell = cell_sprite.duplicate()
			new_cell.position = Vector2(x*CELL_WIDTH, y*CELL_WIDTH)
			origin.add_child(new_cell)
