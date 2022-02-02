extends Node


var network = NetworkedMultiplayerENet.new()
const PORT = 5000
const MAX_PLAYERS = 10


func _ready():
	print("server initiating...")
	network.create_server(PORT, MAX_PLAYERS)
	get_tree().set_network_peer(network)
	print("SERVER INITIATED")
	
	get_tree().connect("network_peer_connected", self, "_client_connected")
	get_tree().connect("network_peer_disconnected", self, "_client_disconnected")


func _client_connected(player_id):
	print("Client: ", str(player_id), " connected")


func _client_disconnected(player_id):
	print("Client: ", str(player_id), " disconnected")


remote func test(x):
	var player_id = get_tree().get_rpc_sender_id()
	
	print("test func called")
	print("player_id: ", player_id)
	print("x: ", x)
	# rpc_id(player_id, "test")
