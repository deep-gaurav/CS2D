extends Node2D

func _ready():
	var n=0
	for x in multiplayer.players:
		n+=1
		var pl=load("res://player.tscn")
		var pli=pl.instance()
		add_child(pli)
		pli.global_position=get_node("start points/point "+str(n)).global_position
		pli.set_name(str(x))
		if x == get_tree().get_network_unique_id():
			pli.set_network_master(get_tree().get_network_unique_id())
	for x in multiplayer.players:
		get_node(str(x)).delrest()
		
func _process(delta):
	if get_tree().get_nodes_in_group('player').size()==1:
		$CanvasLayer/won.text=multiplayer.players[int(get_tree().get_nodes_in_group('player')[0].get_name())]+' WON'
		$CanvasLayer/won.show()
		if get_tree().is_network_server():
			$CanvasLayer/play.show()
sync func endgame():
	get_tree().reload_current_scene()

func _on_play_pressed():
	rpc('endgame')
