extends Node


var network = NetworkedMultiplayerENet.new()
var ip = "127.0.0.1"
const PORT = 5000


func _ready():
	print("attempting to connect to server...")
	network.create_client(ip, PORT)
	get_tree().set_network_peer(network)
	
	network.connect("connection_failed", self, "_on_connection_failed")
	network.connect("connection_succeeded", self, "_on_connection_succeeded")


func _on_connection_failed():
	print("failed to connect")


func _on_connection_succeeded():
	print("connection successful")
	rpc_id(1, "test", [Vector2(), Vector2(1, 2)])  # id 1 is the server


# need to make funcs to accept updates and send inputs to server
