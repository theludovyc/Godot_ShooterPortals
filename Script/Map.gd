extends Node

var wall_NO=preload("res://Prefab/Wall_NO.tscn")
var wall_N=preload("res://Prefab/Wall_N.tscn")
var wall_NE=preload("res://Prefab/Wall_NE.tscn")
var wall_O=preload("res://Prefab/Wall_O.tscn")
var wall_E=preload("res://Prefab/Wall_E.tscn")
var wall_SO=preload("res://Prefab/Wall_SO.tscn")
var wall_S=preload("res://Prefab/Wall_S.tscn")
var wall_SE=preload("res://Prefab/Wall_SE.tscn")

var northPortal=Vector2(16, 10)
var southPortal=Vector2(16, 14)
var westPortal=Vector2(14, 12)
var eastPortal=Vector2(18, 12)

var roomX=14
var roomY=10
var roomW=5
var roomH=5

func genWall(wall, x, y):
	var node=wall.instance()
	add_child(node)
	node.position=Vector2(x*32, y*32)

func genRoom():
	for body in get_children():
		body.queue_free()

	genWall(wall_NO, roomX, roomY)
	genWall(wall_NE, roomX+roomW-1, roomY)

	if northPortal == Vector2(0, 0):
		for i in range(1, roomW-1):
			genWall(wall_N, roomX+i, roomY)
	else:
		for i in range(1, roomW-1):
			if Vector2(roomX+i, roomY) == northPortal:
				continue

			genWall(wall_N, roomX+i, roomY)

	genWall(wall_SO, roomX, roomY+roomH-1)
	genWall(wall_SE, roomX+roomW-1, roomY+roomH-1)

	if southPortal == Vector2(0, 0):
		for i in range(1, roomW-1):
			genWall(wall_S, roomX+i, roomY+roomH-1)
	else:
		for i in range(1, roomW-1):
			if Vector2(roomX+i, roomY+roomH-1) == southPortal:
				continue

			genWall(wall_S, roomX+i, roomY+roomH-1)

	if westPortal == Vector2(0, 0):
		for i in range(1, roomH-1):
			genWall(wall_O, roomX, roomY+i)
	else:
		for i in range(1, roomH-1):
			if Vector2(roomX, roomY+i) == westPortal:
				continue

			genWall(wall_O, roomX, roomY+i)

	if eastPortal == Vector2(0, 0):
		for i in range(1, roomH-1):
			genWall(wall_E, roomX+roomW-1, roomY+i)
	else:
		for i in range(1, roomH-1):
			if Vector2(roomX+roomW-1, roomY+i) == eastPortal:
				continue

			genWall(wall_E, roomX+roomW-1, roomY+i)
	pass

func genRoomNorth():
	roomY=northPortal.y-2

	if roomY!=0:
		roomY=randi()%int(roomY)

	roomH=int(northPortal.y)-roomY+1

	roomX=randi()%int(northPortal.x)

	roomW=randi()%(24-int(northPortal.x))-roomX

	southPortal=northPortal

	if roomY>1:
		northPortal.x=roomX+randi()%roomW+1
		northPortal.y=roomY
	else:
		northPortal=Vector2(0, 0)

	genRoom()
	pass

func genRoomSouth():
	roomY=int(southPortal.y)

	roomH=3

	if roomY+roomH-1 < 32:
		roomH=randi()%(29-roomY)

	roomX=randi()%int(southPortal.x)

	roomW=randi()%(24-int(southPortal.x))-roomX

	northPortal=southPortal

	if roomY+roomH-1 < 29:
		southPortal.x=roomX+1+randi()%roomW
		southPortal.y=roomY+roomH-1
	else:
		southPortal=Vector2(0, 0)

	genRoom()
	pass

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here

	genRoom()
	pass
