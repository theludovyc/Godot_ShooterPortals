extends Node

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	if $Player.position.y < $Map.northPortal.y*32:
		#var vec=northPortal
		#northPortal.y-=4
		$Map.genRoomNorth()

	if(Input.is_key_pressed(KEY_ESCAPE)):
		get_tree().quit()
	pass
