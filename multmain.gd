extends Node

remote var players={}
var self_name

var bullet

const MAX_PLAYERS=5
func _ready():
	bullet=load("res://bullet.tscn")
	get_tree().connect('connected_to_server',self,"connected")
	get_tree().connect('network_peer_connected',self,"player_connected")
func make_server(port,name_i):
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(int(port), MAX_PLAYERS)
	peer.set_bind_ip('192.168.0.300')
	get_tree().set_network_peer(peer)
	get_tree().set_meta("network_peer", peer)
	self_name=name_i
	players[1]=name_i
	
func make_client(ip,port,name_i):
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(ip,int(port))
	get_tree().set_network_peer(peer)
	get_tree().set_meta("network_peer",peer)
	self_name=name_i
	
remote func add_player(id,name_i):
	if get_tree().is_network_server():
		players[id]=name_i
		rset("players",players)
func player_connected(id):
	print('someone connected')
func connected():
	rpc("add_player",get_tree().get_network_unique_id(),self_name)