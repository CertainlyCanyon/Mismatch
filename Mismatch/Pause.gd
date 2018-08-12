extends Node

func pause(pause_bool, param):
	for child in get_children():
		if(child.has_method("pause")):
			child.pause(pause_bool, param)
