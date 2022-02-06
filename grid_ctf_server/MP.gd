extends Node


var network = NetworkedMultiplayerENet.new()
const PORT = 5000
const MAX_PLAYERS = 10

var grid  # register grid scene to server

var connected_players = []  # list of active players

func _process(delta):  # testing
	if Input.is_action_just_pressed("ui_accept"):
		connected_players.append(12345)
		grid.spawn_player(connected_players.find(12345), 1)  # send index of connected player
		send_game_state(grid.player_data, grid.scores)


func start_server(grid_in, max_players : int = MAX_PLAYERS):
	grid = grid_in  # register grid scene to server
	# grid.test()  - can call internal functions
	
	print("server initiating...")
	network.create_server(PORT, MAX_PLAYERS)
	get_tree().set_network_peer(network)
	
	get_tree().connect("network_peer_connected", self, "_client_connected")
	get_tree().connect("network_peer_disconnected", self, "_client_disconnected")


func _client_connected(player_rpc_id):
	print("client: ", str(player_rpc_id), " connected")
#	connected_players.append(player_rpc_id)
#	var requested_team = rpc_id(player_rpc_id, "get_team")
#	print(requested_team)



remote func spawn_player(requested_team):
	if not (requested_team == 0 or requested_team == 1):
		requested_team = randi() % 2
	print("SPAWN PLAYER CALLED: ", requested_team)
	var player_rpc_id = get_tree().get_rpc_sender_id()
	connected_players.append(player_rpc_id)
	grid.spawn_player(connected_players.find(player_rpc_id), requested_team)  # send index of connected player
	send_game_state(grid.player_data, grid.scores)
	send_coords(grid.player_coords, grid.flag_coords)


func _client_disconnected(player_rpc_id):
	print("Client: ", str(player_rpc_id), " disconnected")
	grid.remove_player(connected_players.find(player_rpc_id))


remote func receive_player_input(dir : Vector2):
	var player_rpc_id = get_tree().get_rpc_sender_id()
	print("received", dir, " from player: ", player_rpc_id)
	grid.move_player(connected_players.find(player_rpc_id), dir)


remote func test(x = -1):
	var player_rpc_id = get_tree().get_rpc_sender_id()
	
	print("test func called")
	print("player_rpc_id: ", player_rpc_id)
	print("x: ", x)
	# rpc_id(player_rpc_id, "test")


func send_coords(player_coords, flag_coords):
	for player_rpc_id in connected_players:
		rpc_unreliable_id(player_rpc_id, "receive_coords", player_coords, flag_coords)


func send_game_state(player_data, scores):
	for player_rpc_id in connected_players:
		rpc_id(player_rpc_id, "receive_game_state", player_data, scores)

# need to make functions to send updates to all players, and receive inputs from individual players
