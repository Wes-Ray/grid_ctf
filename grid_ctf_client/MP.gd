extends Node


var network = NetworkedMultiplayerENet.new()
var SERVER_IP = "127.0.0.1"
const PORT = 5000

var grid  # ref to grid representation scene
var requested_team := 2


func connect_to_server(grid_in):
	grid = grid_in
	
	print("attempting to connect to server at ", SERVER_IP, "...")
	network.create_client(SERVER_IP, PORT)
	get_tree().set_network_peer(network)
	
	network.connect("connection_failed", self, "_on_connection_failed")
	network.connect("connection_succeeded", self, "_on_connection_succeeded")


func spawn_player():
	print("spawn_player called")
	rpc_id(1, "spawn_player", requested_team)


func send_input(dir : Vector2):
	rpc_id(1, "receive_player_input", dir)


remote func receive_coords(new_player_coords, new_flag_coords):
	grid.player_coords = new_player_coords
	grid.flag_coords = new_flag_coords


remote func receive_game_state(new_state, new_scores):
	grid.player_data = new_state
	grid.scores = new_scores
	grid.refresh_hud()
	grid.refresh_player_states()


#remote func spawn_player(player_id, team):
#	grid.spawn_player(player_id, team)


func _on_connection_failed():
	print("failed to connect")


func _on_connection_succeeded():
	print("connection successful")
	spawn_player()


# need to make funcs to accept updates and send inputs to server
