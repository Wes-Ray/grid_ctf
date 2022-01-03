extends Node2D

var cell_res = load("res://grid/grid_cell.png")

var CELL_WIDTH := 32
var GRID_WIDTH := 28
var GRID_HEIGHT := 16

onready var origin := get_node("origin")
#onready var player := get_node("origin/player")

onready var player_inst := preload("res://player.tscn")

var players = []  # local player objects, aligns with player_data array
# list of player locations, aligns with players array, updated each tick
var player_coords = []
# list of player data, received from server, aligns with players array, updated only when needed
# use enum for specific data, player_data[player_id][TEAM]
var player_data = []
enum Pd {TEAM = 0, COLOR = 1}

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
	
	# check for collisions between players
	# if player not on same team, and check what side they're on
	
	
	
	
	# update grid reflection of player_cell_pos
	for id in range(len(players)):
		players[id].position = (player_coords[id] * CELL_WIDTH) + origin.position


# this function should be used server-side, a remote function for the client will 
# only send inputs with their player_id to the server
func move_player(player_id : int, dir : Vector2) -> void:
	# clamp cell_pos to grid_width and height
	var new_pos = player_coords[player_id] + dir
	var new_x = clamp(new_pos.x, 0, GRID_WIDTH-1)
	var new_y = clamp(new_pos.y, 0, GRID_HEIGHT-1)
	new_pos = Vector2(new_x, new_y)  # update with clamp
	
	# check for collisions
	for other_p_id in range(len(player_coords)):
		if other_p_id != player_id:  # skip yourself
			if player_coords[other_p_id] == new_pos:  # landed on other player
				print("COLLISION!!")
	
	player_coords[player_id]= Vector2(new_pos)


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
		player_coords.append(Vector2(x, 0))
		
		# append array with length of enums
		var new_array = []
		new_array.resize(len(Pd))
		player_data.append(new_array)  
		player_data[x][Pd.TEAM] = x % 2
		
		# create new player and add to list
		var new_player = player_inst.instance()
		origin.add_child(new_player)
		new_players.append(new_player)
	
	print(player_data)
	
	return new_players
