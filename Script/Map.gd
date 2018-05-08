extends Node

var whiteWall=preload("res://Prefab/WhiteWall.tscn")

var northPortal=Vector2(16, 10)
var southPortal=Vector2(16, 14)
var westPortal=Vector2(14, 12)
var eastPortal=Vector2(18, 12)

var roomX=14
var roomY=10
var roomW=5
var roomH=5

func genWall(x, y):
	var node=whiteWall.instance()
	add_child(node)
	node.position=Vector2(x*32, y*32)

func genRoom():
	for body in get_children():
		body.queue_free()

	for i in range(roomW):
		if Vector2(roomX+i, roomY) != northPortal:
			genWall(roomX+i, roomY)

		if Vector2(roomX+i, roomY+roomH-1) != southPortal:
			genWall(roomX+i, roomY+roomH-1)

	for i in range(roomH-2):
		if Vector2(roomX, roomY+1+i) != westPortal:
			genWall(roomX, roomY+1+i)

		if Vector2(roomX+roomW-1, roomY+1+i) != eastPortal:
			genWall(roomX+roomW-1, roomY+1+i)
	pass

func genRoomNorth():
	roomY=northPortal.y-2

	if roomY!=0:
		roomY=randi()%int(roomY)

	roomH=int(northPortal.y)-roomY+1

	roomX=randi()%int(northPortal.x)

	roomW=int(northPortal.x)-roomX+randi()%(24-int(northPortal.x))

	southPortal=northPortal

	northPortal.x=roomX+randi()%roomW+1
	northPortal.y=roomY

	genRoom()
	pass

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here

	genRoom()
	pass
