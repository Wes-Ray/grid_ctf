extends Node


var network = NetworkedMultiplayerENet.new()
const PORT = 5000
const MAX_PLAYERS = 10

var grid  # register grid scene to server

func _ready():
	pass


func start_server(grid_in, max_players : int = MAX_PLAYERS):
	grid = grid_in  # register grid scene to server
	# grid.test()  - can call internal functions
	
	print("server initiating...")
	network.create_server(PORT, MAX_PLAYERS)
	get_tree().set_network_peer(network)
	
	get_tree().connect("network_peer_connected", self, "_client_connected")
	get_tree().connect("network_peer_disconnected", self, "_client_disconnected")


func _client_connected(player_id):
	print("Client: ", str(player_id), " connected")
	grid.spawn_player(player_id)


func _client_disconnected(player_id):
	print("Client: ", str(player_id), " disconnected")


remote func receive_player_input(dir : Vector2):
	var player_id = get_tree().get_rpc_sender_id()
	print("received", dir, " from player: ", player_id)
	grid.move_player(player_id, dir)


remote func test(x = -1):
	var player_id = get_tree().get_rpc_sender_id()
	
	print("test func called")
	print("player_id: ", player_id)
	print("x: ", x)
	# rpc_id(player_id, "test")


# need to make functions to send updates to all players, and receive inputs from individual players
