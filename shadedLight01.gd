extends Sprite

var radius
var par
var parent_radius
var holding=0

const hold_inter=0.3
var tmp_ind


export var Player_Path=NodePath()
var player
func _ready():
	set_process_input(true)
	radius=texture.get_width()/2
	par=get_parent()
	
	parent_radius=par.texture.get_width()/2
	player=get_node(Player_Path)
func _process(delta):
	#Restore Joystick
	if position!=Vector2(0,0) and !holding:
		move_local_x(-(position.x/2))
		move_local_y(-(position.y/2))
	
	var dis=(position.length()/parent_radius)*20000
	
	#Do your action
	player.rotation=(Vector2(0,0).angle_to_point(-position))
	if dis>2500:
		player.curwalk=2*dis
	else:
		player.curwalk=0
		

func _unhandled_input(event):
	if event is InputEventScreenDrag:
		if global_position.distance_to(event.position)<radius+50 and par.global_position.distance_to(event.position)<parent_radius+150:
			position=(event.position-get_parent().global_position).clamped(parent_radius)
			holding=true
			event.index=10
	elif event is InputEventScreenTouch and true:
		if global_position.distance_to(event.position)<radius:
			event.index=10
			holding=true
		if !event.is_pressed() and event.index==10:
			print(event.index)
			holding=false