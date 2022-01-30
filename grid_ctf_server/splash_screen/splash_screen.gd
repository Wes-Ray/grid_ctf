extends Node


# TODO: Add IP to connect to specific server

var server_ip := "127.0.0.1"  # server ip
var server_port := 51234
var local_ip := "127.0.0.2"  # should be dhcp'd eventually

func _ready():
	pass
	print("connecting...")
	
#	var peer = NetworkedMultiplayerENet.new()
#	peer.create_client(server_ip, server_port)
#	get_tree().network_peer = peer
	
	get_tree().change_scene("res://grid/grid.tscn")

