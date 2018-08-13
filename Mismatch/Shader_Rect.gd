extends ColorRect

onready var timer = 0;
onready var color_timer = 0;
var run = false
var pixelate = false
const SPEED = .7
var color_speed = 0

func _process(delta):
	color_timer += color_speed/5
	material.set_shader_param("color_timer", color_timer)
	
	if(run):
		if(pixelate):
			if(!timer > 1.5):
				timer += SPEED * delta
			else:
				run = false
			material.set_shader_param("timer", timer)
		else:
			if(!timer <= 0):
				timer -= SPEED * delta
			else:
				run = false
			material.set_shader_param("timer", timer)

func _on_set_pixelate(value):
	run = true
	pixelate = value


func change_color_speed(val):
	color_speed = val
	
