extends Node2D

var cell_res = load("res://grid/grid_cell.png")

var CELL_WIDTH := 32
var GRID_WIDTH := 28
var GRID_HEIGHT := 16

onready var origin := get_node("origin")
#onready var player := get_node("origin/player")

onready var player_inst := preload("res://player.tscn")

var players = []  # local player objects, aligns with player_data array
var player_data = []  # list of player data, received from server, aligns with players array

enum {COORDS = 0, COLOR = 1}

func _ready():
	generate_map()
	players = generate_players()


func _process(delta):
	# move local player 0
	if Input.is_action_just_pressed("ui_right"):
		move_player(0, Vector2.RIGHT)
	elif Input.is_action_just_pressed("ui_left"):
		move_player(0, Vector2.LEFT)
	elif Input.is_action_just_pressed("ui_up"):
		move_player(0, Vector2.UP)
	elif Input.is_action_just_pressed("ui_down"):
		move_player(0, Vector2.DOWN)
	
	# move local player 1, this is only for debug
	if Input.is_action_just_pressed("move_right"):
		move_player(1, Vector2.RIGHT)
	elif Input.is_action_just_pressed("move_left"):
		move_player(1, Vector2.LEFT)
	elif Input.is_action_just_pressed("move_up"):
		move_player(1, Vector2.UP)
	elif Input.is_action_just_pressed("move_down"):
		move_player(1, Vector2.DOWN)
	
	# update grid reflection of player_cell_pos
	for id in range(len(players)):
		players[id].position = (player_data[id][COORDS] * CELL_WIDTH) + origin.position


func move_player(player_id : int, dir : Vector2) -> void:
	# clamp cell_pos to grid_width and height
	var new_pos = player_data[player_id][COORDS] + dir
	var new_x = clamp(new_pos.x, 0, GRID_WIDTH-1)
	var new_y = clamp(new_pos.y, 0, GRID_HEIGHT-1)
	player_data[player_id][COORDS] = Vector2(new_x, new_y)
	print(player_data)


func generate_map() -> void:
	var cell_sprite = Sprite.new()
	cell_sprite.texture = cell_res
	cell_sprite.centered = false
	
	for x in range(GRID_WIDTH):
		for y in range(GRID_HEIGHT):
			var new_cell = cell_sprite.duplicate()
			new_cell.position = Vector2(x * CELL_WIDTH, y * CELL_WIDTH)
			origin.add_child(new_cell)


func generate_players(player_count : int = 2) -> Array:
	
	var new_players = []
	# generate player_data array SERVER
	for x in range(player_count):
		player_data.append([Vector2(), Color()])
		
		# create new player and add to list
		var new_player = player_inst.instance()
		origin.add_child(new_player)
		new_players.append(new_player)
	
	return new_players
