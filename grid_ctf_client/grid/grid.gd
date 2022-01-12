extends Node2D

var scores = [0, 0]  # red, blue scores
export var SCORE_LIMIT = 5

var cell_res_red = load("res://grid/grid_cell_red.png")
var cell_res_blue = load("res://grid/grid_cell_blue.png")

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
enum Pd {TEAM = 0, ALIVE = 1, HAS_FLAG = 2}

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
	player_coords[player_id]= Vector2(new_x, new_y)  # update with clamp
	
	# check for collisions with players, only collide if attacker is in defender territory
	# red is 0 and on left, blue is 1 and on right
	# only collides when a player moves into another for now
	for other_p_id in range(len(player_coords)):
		if player_data[player_id][Pd.ALIVE]:  # only collide if player is alive
			if other_p_id != player_id:  # skip yourself
				if player_coords[other_p_id] == player_coords[player_id]:  # landed on other player
					if player_data[other_p_id][Pd.TEAM] != player_data[player_id][Pd.TEAM]:  # player on other team
						if player_data[other_p_id][Pd.ALIVE]:
							# check if other_player is on attacking player's side
							#if x < (GRID_WIDTH/2):
							# if collider is red team, collide with players on left side only
							var on_sides = false
							if player_data[player_id][Pd.TEAM] == 0:  # red team
								if player_coords[player_id].x < GRID_WIDTH/2:
									on_sides = true
							# elif blue team
							elif player_data[player_id][Pd.TEAM] == 1:  # blue team
								if player_coords[player_id].x >= GRID_WIDTH/2:
									on_sides = true
							# else no collision
							if on_sides:
								print("COLLISION!!")
								players[other_p_id].update_color(Color(1, 1, 1, .3))  # change color of other player
								player_data[other_p_id][Pd.ALIVE] = false
								player_data[other_p_id][Pd.HAS_FLAG] = false  # drop flag
	
	# check for collision with flag
	for flag_id in range(len(flags)):
		if player_data[player_id][Pd.ALIVE] == true:
			if player_coords[player_id] == flag_coords[flag_id]:  # check for flag collision
				if player_data[player_id][Pd.TEAM] != flag_id:  # team = 0 or 1 (red or blue)
					print("flag collided")
					player_data[player_id][Pd.HAS_FLAG] = true
	
	# if player HAS_FLAG, update flag position
	if player_data[player_id][Pd.HAS_FLAG] == true:
		var player_team = player_data[player_id][Pd.TEAM]
		var opposite_team_num = (player_team + 1) % 2
		flag_coords[opposite_team_num] = player_coords[player_id]
		
		# red 0 on right side with flag
		if player_team == 0:
			if flag_coords[opposite_team_num].x < GRID_WIDTH/2:
				print("RED CAPTURED FLAG")
				scores[player_team] = scores[player_team] + 1
				flag_coords[opposite_team_num] = Vector2(GRID_WIDTH-1, GRID_HEIGHT/2)  # reset flag
				player_data[player_id][Pd.HAS_FLAG] = false
				refresh_scores()
		# blue 1 on left side with flag
		elif player_team == 1:
			if flag_coords[opposite_team_num].x >= GRID_WIDTH/2:
				print("BLUE CAPTURED FLAG")
				scores[player_team] = scores[player_team] + 1
				flag_coords[opposite_team_num] = Vector2(0, GRID_HEIGHT/2)  # reset flag
				player_data[player_id][Pd.HAS_FLAG] = false
				refresh_scores()


func generate_map() -> void:
	var cell_sprite_red = Sprite.new()
	cell_sprite_red.texture = cell_res_red
	cell_sprite_red.centered = false
	var cell_sprite_blue = Sprite.new()
	cell_sprite_blue.texture = cell_res_blue
	cell_sprite_blue.centered = false
	
	for x in range(GRID_WIDTH):
		for y in range(GRID_HEIGHT):
			var new_cell
			if x < (GRID_WIDTH/2):
				new_cell = cell_sprite_red.duplicate()
			else:
				new_cell = cell_sprite_blue.duplicate()
			new_cell.position = Vector2(x * CELL_WIDTH, y * CELL_WIDTH)
			origin.add_child(new_cell)


func generate_players(player_count : int = 2) -> void:
	
	# generate player_data array SERVER
	for player_id in range(player_count):
		player_coords.append(Vector2(player_id*2, player_id*2))  # temp
		
		# append array with length of enums
		var new_array = []
		new_array.resize(len(Pd))
		player_data.append(new_array)  
		player_data[player_id][Pd.TEAM] = player_id % 2
		player_data[player_id][Pd.ALIVE] = true
		player_data[player_id][Pd.HAS_FLAG] = false
		
		# create new player and add to list
		var new_player = player_inst.instance()
		new_player.update_team_color(player_data[player_id][Pd.TEAM])  # set color based on team number
#		origin.add_child(new_player)
		add_child(new_player)
		players.append(new_player)


# called to update scores
func refresh_scores():
	$red_score.text = str(scores[0])
	$blue_score.text = str(scores[1])
	if scores[0] >= SCORE_LIMIT:
		print("red wins!")
	elif scores[1] >= SCORE_LIMIT:
		print("blue wins!")


func generate_flags() -> void:
	for x in range(2):  # only 2 flags
		var new_flag = flag_inst.instance()
		add_child(new_flag)
		flags.append(new_flag)
	
	# team 0 location
	flag_coords[0] = Vector2(0, GRID_HEIGHT/2)
	flags[0].set_team(0)
	# team 1 location
	flag_coords[1] = Vector2(GRID_WIDTH-1, GRID_HEIGHT/2)
	flags[1].set_team(1)
