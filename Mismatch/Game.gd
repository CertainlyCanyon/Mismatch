extends Node

func _ready():
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func pause(pause_bool):
	print("pausing")
	for child in get_children():
		if(child.has_method("pause")):
			child.pause(pause_bool, null)

func win():
	pass
func win_level():
	pause(true)
func lose():
	pause(true)
