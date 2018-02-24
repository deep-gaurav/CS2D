extends Control
func _ready():
	
	if !get_tree().is_network_server():
		$"Start Game".disabled=true
	else:
		print(IP.get_local_addresses())
		for x in IP.get_local_addresses():
			$Label.text+=x+" , "
func _process(delta):
	$ItemList.clear()
	for x in multiplayer.players:
		if x == get_tree().get_network_unique_id():
			$ItemList.add_item(str(x)+" "+multiplayer.players[x]+ " (You)" )
		else:
			$ItemList.add_item(str(x)+" "+multiplayer.players[x] )

func _on_Start_Game_pressed():
	rpc("start")
sync func start():
	get_tree().change_scene("res://testscene1.tscn")
