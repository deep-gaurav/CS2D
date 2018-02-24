extends Node2D

func _ready():
	print(IP.get_local_addresses())

func _on_server_pressed():
	multiplayer.make_server($port.text,$Name.text)
	load_playerlist()

func _on_client_pressed():
	multiplayer.make_client($ip.text,$port.text,$Name.text)
	load_playerlist()

func load_playerlist():
	get_tree().change_scene("res://lobby_players.tscn")
