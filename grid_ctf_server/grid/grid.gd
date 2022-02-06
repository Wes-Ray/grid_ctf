extends Node2D


var scores = [0, 0]  # red, blue scores
export var SCORE_LIMIT = 5

var cell_res_red = load("res://grid/grid_cell_red.png")
var cell_res_blue = load("res://grid/grid_cell_blue.png")
var cell_res_gray = load("res://grid/grid_cell.png")

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

onready var flag_reset_timers := [Timer.new(), Timer.new()]
var FLAG_RESET_TIME := 5  # time in seconds to reset flag


func _ready():
	pass
	MP.start_server(self)
#	var x = MP  # global MP singleton
#	print("test max p: ", x.MAX_PLAYERS)
#	x.test()

	# can remove gfx later
	generate_map()
#	generate_players()
	generate_flags()

	# connect timers to functions
	add_child(flag_reset_timers[0])
	flag_reset_timers[0].connect("timeout", self, "reset_flag", [1])
	add_child(flag_reset_timers[1])
	flag_reset_timers[1].connect("timeout", self, "reset_flag", [0])


#func _process(delta):
#	pass
#	# update grid reflection of player_cell_pos
#	for id in range(len(players)):
#		players[id].position = (player_coords[id] * CELL_WIDTH) + origin.position
#
#	# draw flags
#	for id in range(len(flags)):
#		flags[id].position = (flag_coords[id] * CELL_WIDTH) + origin.position


# this function should be used server-side, a remote function for the client will 
# only send inputs with their player_id to the server
func move_player(player_id : int, dir : Vector2) -> void:
	# clamp cell_pos to grid_width and height, barring safe zones on either side
	var new_pos = player_coords[player_id] + dir
	# clamp new_x based on safe zones for red/blue
	var new_x
	if player_data[player_id][Pd.TEAM] == 0:  # red can't go all the way left
		new_x = clamp(new_pos.x, 1, GRID_WIDTH-1)
	elif player_data[player_id][Pd.TEAM] == 1:  # blue can't go all the way right
		new_x = clamp(new_pos.x, 0, GRID_WIDTH-2)
	var new_y = clamp(new_pos.y, 0, GRID_HEIGHT-1)
	player_coords[player_id]= Vector2(new_x, new_y)  # update with clamp
	
	
	# check for collisions with players, only collide if attacker is in defender territory
	# red is 0 and on left, blue is 1 and on right
	# only collides when a player moves into another for now
	var game_update_required = false  # flag to update game data if needed
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
							if on_sides:  # kill other player if on sides
								print("COLLISION ON SIDES")
								players[other_p_id].set_alive(false)
								player_data[other_p_id][Pd.ALIVE] = false
								# if other player has flag, drop flag and start reset timer
								if player_data[other_p_id][Pd.HAS_FLAG] == true:
									player_data[other_p_id][Pd.HAS_FLAG] = false  # drop flag
									start_flag_reset_timer(other_p_id)
								game_update_required = true
							elif not on_sides:  # kill self if on same side
								print("COLLISION OFF SIDES")
								players[player_id].set_alive(false)
								player_data[player_id][Pd.ALIVE] = false
								# if other player has flag, drop flag and start reset timer
								if player_data[player_id][Pd.HAS_FLAG] == true:
									player_data[player_id][Pd.HAS_FLAG] = false  # drop flag
									start_flag_reset_timer(player_id)
								game_update_required = true
	
	# respawn player, if dead and next to safe zone
	if player_data[player_id][Pd.ALIVE] == false:
		if player_data[player_id][Pd.TEAM] == 0:  # red, left side respawn
			if player_coords[player_id].x == 1:
				players[player_id].set_alive(true)
				player_data[player_id][Pd.ALIVE] = true
				game_update_required = true
		elif player_data[player_id][Pd.TEAM] == 1:  # blue, right side respawn
			if player_coords[player_id].x == GRID_WIDTH-2:
				players[player_id].set_alive(true)
				player_data[player_id][Pd.ALIVE] = true
				game_update_required = true
	
	# check for collision with flag
	for flag_id in range(len(flags)):
		if player_data[player_id][Pd.ALIVE] == true:
			if player_coords[player_id] == flag_coords[flag_id]:  # check for flag collision with goal flag
				if player_data[player_id][Pd.TEAM] != flag_id:  # team = 0 or 1 (red or blue)
					print("flag collided")
					player_data[player_id][Pd.HAS_FLAG] = true
					game_update_required = true
				else:
					player_coords[player_id] = Vector2(new_x, new_y) + ( dir*-1 )
#			elif player_coords[player_id] == flag_coords[(player_id + 1) % 2]:  # check for collision with own flag, no puppy guarding
				
	
	# if player HAS_FLAG, update flag position
	if player_data[player_id][Pd.HAS_FLAG] == true:
		var player_team = player_data[player_id][Pd.TEAM]
		var opposite_team_num = (player_team + 1) % 2
		flag_coords[opposite_team_num] = player_coords[player_id]
		
		# red 0 with flag, capture check
		if player_team == 0:
			if flag_coords[opposite_team_num].x == 1:  #
				print("RED CAPTURED FLAG")
				scores[player_team] = scores[player_team] + 1
				reset_flag(opposite_team_num)
				player_data[player_id][Pd.HAS_FLAG] = false
				refresh_hud()
				game_update_required = true
		# blue 1 flag, capture check
		elif player_team == 1:
			if flag_coords[opposite_team_num].x == GRID_WIDTH-2:
				print("BLUE CAPTURED FLAG")
				scores[player_team] = scores[player_team] + 1
				reset_flag(opposite_team_num)
				player_data[player_id][Pd.HAS_FLAG] = false
				refresh_hud()
				game_update_required = true
	
	MP.send_coords(player_coords, flag_coords)
	
	if game_update_required == true:
		MP.send_game_state(player_data, scores)


func reset_flag(flag_id) -> void:
	if flag_id == 0:  # reset red
		flag_coords[0] = Vector2(0, GRID_HEIGHT/2)
		flag_reset_timers[0].stop()
		MP.send_game_state(player_data, scores)
	elif flag_id == 1:  # reset blue
		flag_coords[1] = Vector2(GRID_WIDTH-1, GRID_HEIGHT/2)
		flag_reset_timers[1].stop()
		MP.send_game_state(player_data, scores)


func start_flag_reset_timer(flag_id : int) -> void:
	flag_reset_timers[flag_id].wait_time = FLAG_RESET_TIME
	flag_reset_timers[flag_id].start()


func generate_map() -> void:
	var cell_sprite_red = Sprite.new()
	cell_sprite_red.texture = cell_res_red
	cell_sprite_red.centered = false
	var cell_sprite_blue = Sprite.new()
	cell_sprite_blue.texture = cell_res_blue
	cell_sprite_blue.centered = false
	var cell_sprite_gray = Sprite.new()
	cell_sprite_gray.texture = cell_res_gray
	cell_sprite_gray.centered = false
	
	for x in range(GRID_WIDTH):
		for y in range(GRID_HEIGHT):
			var new_cell
			if x == 0 or x == GRID_WIDTH-1:
				new_cell = cell_sprite_gray.duplicate()
			elif x < (GRID_WIDTH/2):
				new_cell = cell_sprite_red.duplicate()
			else:
				new_cell = cell_sprite_blue.duplicate()
			new_cell.position = Vector2(x * CELL_WIDTH, y * CELL_WIDTH)
			origin.add_child(new_cell)


#func generate_players(player_count : int = 2) -> void:
#
#	# generate player_data array SERVER
#	for player_id in range(player_count):
#		spawn_player(player_id, player_id%2)


func spawn_player(player_id, team):
	# set coords based on team
	if team == 0:  # red team
		player_coords.append(Vector2(1,0))
	elif team == 1:  # blue team
		player_coords.append(Vector2(GRID_WIDTH-2, GRID_HEIGHT-1))
	
	# append array with length of enums
	var new_array = []
	new_array.resize(len(Pd))
	player_data.append(new_array)  
	player_data[player_id][Pd.TEAM] = team
	player_data[player_id][Pd.ALIVE] = true
	player_data[player_id][Pd.HAS_FLAG] = false
	
	# create new player and add to list
	var new_player = player_inst.instance()
	new_player.update_team_color(player_data[player_id][Pd.TEAM])  # set color based on team number
#		origin.add_child(new_player)
	add_child(new_player)
	players.append(new_player)


func remove_player(player_id):
	print("remove player: ", player_id)


# called to update scores
func refresh_hud():
	$hud/red_score.text = str(scores[0])
	$hud/blue_score.text = str(scores[1])
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
