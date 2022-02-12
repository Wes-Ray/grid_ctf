extends Node2D

export var SERVER_IP = "127.0.0.1"

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
	# connect to server
	MP.connect_to_server(self)
	
	generate_map()
#	generate_players()
	generate_flags()
	
	# connect timers to functions
	add_child(flag_reset_timers[0])
	flag_reset_timers[0].connect("timeout", self, "reset_flag", [1])
	add_child(flag_reset_timers[1])
	flag_reset_timers[1].connect("timeout", self, "reset_flag", [0])


func test(x):
	print("TEST FUNC CALLED", x)


func _process(delta):
	# on server, this should mostly just be waiting for player movement packets
	
	# send direction inputs to server
	if Input.is_action_just_pressed("ui_right"):
		move(Vector2.RIGHT)
	elif Input.is_action_just_pressed("ui_left"):
		move(Vector2.LEFT)
	elif Input.is_action_just_pressed("ui_up"):
		move(Vector2.UP)
	elif Input.is_action_just_pressed("ui_down"):
		move(Vector2.DOWN)
	
	
	# check for added players
	if len(player_data) > len(players):
		for x in range(len(players), len(player_data)):
			spawn_player(x, player_data[x][Pd.TEAM])
	
	# update grid reflection of player_cell_pos
	for id in range(len(players)):
		pass
		players[id].position = (player_coords[id] * CELL_WIDTH) + origin.position
	
	# draw flags
	for id in range(len(flags)):
		flags[id].position = (flag_coords[id] * CELL_WIDTH) + origin.position



func spawn_player(player_id, team):
	print("Spawn player called")
	# remove
#	if team == 0:  # red team
#		player_coords.append(Vector2(1,0))
#	elif team == 1:  # blue team
#		player_coords.append(Vector2(GRID_WIDTH-2, GRID_HEIGHT-1))
	
	player_coords.append(Vector2(-5, -5))
	
	# create new player and add to list
	var new_player = player_inst.instance()
	new_player.update_team_color(team)  # set color based on team number
	add_child(new_player)
	players.append(new_player)


func refresh_player_states():
	for player_id in range(len(players)):
		players[player_id].set_alive(player_data[player_id][Pd.ALIVE])


func move(dir : Vector2):
	MP.send_input(dir)


func reset_flag(flag_id) -> void:
	if flag_id == 0:  # reset red
		flag_coords[0] = Vector2(0, GRID_HEIGHT/2)
		flag_reset_timers[0].stop()
	elif flag_id == 1:  # reset blue
		flag_coords[1] = Vector2(GRID_WIDTH-1, GRID_HEIGHT/2)
		flag_reset_timers[1].stop()


func start_flag_reset_timer(flag_id : int) -> void:
	flag_reset_timers[flag_id].wait_time = FLAG_RESET_TIME
	flag_reset_timers[flag_id].start()
	print("CALLED")


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
