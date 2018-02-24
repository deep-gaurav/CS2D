extends KinematicBody2D

export var speed_walk=10
export var run= 10
export var health = 100

var bullets=10

var weapon='handgun'

remote var pla=false
remote var curwalk=0
remote var rrot=0
remote var rpos=Vector2(0,0)
func _ready():
	pass

func delrest():
	if get_name()!=str(get_tree().get_network_unique_id()):
		$CanvasLayer.queue_free()
		$Camera2D.queue_free()
	set_network_master(int(get_name()))
	$Name.text=multiplayer.players[int(get_name())]

func _process(delta):
	if is_network_master():
		$CanvasLayer/hp.value=health
		$CanvasLayer/bullets.text=str(bullets)
	if health<=0 and is_network_master():
		var cam=$Camera2D
		remove_child(cam)
		if get_tree().get_nodes_in_group('player').size()>1:
			for x in get_tree().get_nodes_in_group('player'):
				if x != self:
					x.add_child(cam)
					cam.position=Vector2(0,0)
		rpc('del')

func _physics_process(delta):
	if is_network_master():
		var direction=Vector2(cos(rotation),sin(rotation))
	
		move_and_slide(direction*delta*curwalk,Vector2(0,0))
		if !pla:
			if curwalk>10000:
				rpc('animation','-move','run')
			elif curwalk>0:
				rpc('animation','-move','walk')
			else:
				rpc('animation','-idle','idle')
				
		if Input.is_action_just_pressed('fire') and bullets and !pla:
			bullets-=1
			rpc('animation','-shoot','')
			pla=true
			rset('pla',pla)
			rpc('fire')
		
		if Input.is_action_just_pressed('reload'):
			bullets=10
			rpc('animation','-reload','')
			pla=true
			rset('pla',pla)
			
		rpos=position
		rrot=rotation
		rset('rpos',rpos)
		rset('rrot',rrot)
		
	else:
		rotation=rrot
		position=rpos
		
		
sync func fire():
	var direction=Vector2(cos(rotation),sin(rotation))
	var bul=multiplayer.bullet.instance()
	get_parent().add_child(bul)
	bul.global_rotation=global_rotation
	bul.global_position=$firepoint.global_position
	bul.apply_impulse(Vector2(0,0),direction*2000)
#Animations
sync func animation(body_anim,feet_anim):
	
	if feet_anim:
		$feet.play(feet_anim)
	if body_anim:
		$body.play(weapon+body_anim)
sync func del():
	queue_free()

func _on_body_animation_finished():
	if $body.animation==weapon+'-shoot' or $body.animation==weapon+'-reload':
		pla=false
