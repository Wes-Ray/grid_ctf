extends Node


var network = NetworkedMultiplayerENet.new()
const PORT = 5000

var grid  # ref to grid representation scene


func _ready():
	pass


func connect_to_server(grid_in, ip : String):
	grid = grid_in
	
	print("attempting to connect to server at ", ip, "...")
	network.create_client(ip, PORT)
	get_tree().set_network_peer(network)
	
	network.connect("connection_failed", self, "_on_connection_failed")
	network.connect("connection_succeeded", self, "_on_connection_succeeded")


func send_input(dir : Vector2):
	rpc_id(1, "receive_player_input", dir)


remote func receive_positions():
	pass


remote func receive_game_state():
	pass


func _on_connection_failed():
	print("failed to connect")


func _on_connection_succeeded():
	print("connection successful")


# need to make funcs to accept updates and send inputs to server
