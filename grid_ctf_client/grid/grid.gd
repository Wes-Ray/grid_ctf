extends Node2D

var cell_res = load("res://grid/grid_cell.png")

var CELL_WIDTH := 32
var GRID_WIDTH := 28  # should be even number
var GRID_HEIGHT := 15  # should be odd number

onready var origin := get_node("origin")
#onready var player := get_node("origin/player")

onready var player_inst := preload("res://player.tscn")
onready var flag_inst := preload("res://flag.tscn")

var players = []  # local player objects, aligns with player_data array
# list of player locations, aligns with players array, updated each tick
var player_coords = []
# list of player data, received from server, aligns with players array, updated only when needed
# use enum for specific data, player_data[player_id][TEAM]
var player_data = []
enum Pd {TEAM = 0, ALIVE = 1}

var flags = []  # local flag objects, aligned with flag_coords array
var flag_coords = [Vector2(), Vector2()]  # flag coords, updated each tick
var flag_attached_array = [-1, -1]  # flag linked to a player index or none (-1)

func _ready():
	generate_map()
	generate_players()
	generate_flags()


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
		players[id].position = (player_coords[id] * CELL_WIDTH) + origin.position
	
	# draw flags
	for id in range(len(flags)):
		flags[id].position = (flag_coords[id] * CELL_WIDTH) + origin.position


# this function should be used server-side, a remote function for the client will 
# only send inputs with their player_id to the server
func move_player(player_id : int, dir : Vector2) -> void:
	# clamp cell_pos to grid_width and height
	var new_pos = player_coords[player_id] + dir
	var new_x = clamp(new_pos.x, 0, GRID_WIDTH-1)
	var new_y = clamp(new_pos.y, 0, GRID_HEIGHT-1)
	new_pos = Vector2(new_x, new_y)  # update with clamp
	
	# check for collisions with players
	for other_p_id in range(len(player_coords)):
		if player_data[player_id][Pd.ALIVE]:  # only collide if player is alive
			if other_p_id != player_id:  # skip yourself
				if player_coords[other_p_id] == new_pos:  # landed on other player
					if player_data[other_p_id][Pd.ALIVE]:
						print("COLLISION!!")
						players[other_p_id].update_color(Color(1, 1, 1, .3))  # change color of other player
						player_data[other_p_id][Pd.ALIVE] = false
	
	# check for collision with flag
	for flag_id in range(len(flags)):
		pass
	
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


func generate_players(player_count : int = 2):
	
	# generate player_data array SERVER
	for x in range(player_count):
		player_coords.append(Vector2(x*2, x*2))
		
		# append array with length of enums
		var new_array = []
		new_array.resize(len(Pd))
		player_data.append(new_array)  
		player_data[x][Pd.TEAM] = x % 2
		player_data[x][Pd.ALIVE] = true
		
		# create new player and add to list
		var new_player = player_inst.instance()
		origin.add_child(new_player)
		players.append(new_player)


func generate_flags(player_count : int = 2):
	for x in range(player_count):
		var new_flag = flag_inst.instance()
		origin.add_child(new_flag)
		flags.append(new_flag)
	
	# team 0 location
	flag_coords[0] = Vector2(0, GRID_HEIGHT/2)
	# team 1 location
	flag_coords[1] = Vector2(GRID_WIDTH-1, GRID_HEIGHT/2)
