extends Node2D

onready var t_rotation = get_node("Rotation_Timer")
onready var t_color = get_node("Color_Timer")

var pause = false

var color_speed = 0
var rot_speed = 0

func _ready():
	t_rotation.wait_time = rand_range(1,5)
	t_color.wait_time = rand_range(1,5)
	t_rotation.start()
	t_color.start()
	
	color_speed = rand_range(.05,.1)
	rot_speed = rand_range(.05,.1)

func _process(delta):
	if(!pause && get_parent().number_of_prongs > 4):
		get_parent().rotation += rot_speed/7;
	

func _on_Rotation_Timer_timeout():
	rot_speed = -1*sign(rot_speed)*rand_range(.05,.1)
	pass

func pause(pause_bool, param):
	pause = pause_bool
	if(pause):
		get_node("/root/Game/ColorRect").change_color_speed(0)
	else:
		get_node("/root/Game/ColorRect").change_color_speed(color_speed)
	for child in get_children():
		if(child.has_method("pause")):
			child.pause(pause_bool, param)

func _on_Color_Timer_timeout():
	color_speed = -1*sign(color_speed)*rand_range(.05,.1)
	get_node("/root/Game/ColorRect").change_color_speed(color_speed)
	
