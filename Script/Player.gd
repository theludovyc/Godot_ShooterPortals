extends KinematicBody2D
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var moveSpeed=100.0
var maxSpeed=200.0
var stopSpeed=50.0

var move=Vector2()

var mousePos = Vector2()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	update()
	pass

func _physics_process(delta):
	if Input.is_action_pressed("ui_left"):
		move.x-=moveSpeed
		if move.x<-maxSpeed:
			move.x=-maxSpeed
	elif Input.is_action_pressed("ui_right"):
		move.x+=moveSpeed
		if move.x>maxSpeed:
			move.x=maxSpeed
	else:
		if move.x>0:
			move.x-=stopSpeed
			if move.x<0:
				move.x=0
		elif move.x<0:
			move.x+=stopSpeed
			if move.x>0:
				move.x=0

	if Input.is_action_pressed("ui_up"):
		move.y-=moveSpeed
		if move.y<-maxSpeed:
			move.y=-maxSpeed
	elif Input.is_action_pressed("ui_down"):
		move.y+=moveSpeed
		if move.y>maxSpeed:
			move.y=maxSpeed
	else:
		if move.y>0:
			move.y-=stopSpeed
			if move.y<0:
				move.y=0
		elif move.y<0:
			move.y+=stopSpeed
			if move.y>0:
				move.y=0

	move_and_slide(move)
	pass

func _input(event):
	if event is InputEventMouseMotion:
		mousePos=event.position
	pass

func _draw():
	var vec=mousePos-position
	vec=vec.normalized()

	draw_line(24*vec, 54*vec, Color(255, 0, 0), 2)
	pass