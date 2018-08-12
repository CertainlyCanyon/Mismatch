extends ColorRect

onready var timer = 0;
var run = false
var pixelate = false
const SPEED = .3

func _process(delta):
	if(run):
		if(pixelate):
			if(!timer > 1.5):
				timer += SPEED * delta
			else:
				run = false
				timer = 0
			material.set_shader_param("timer", timer)
		else:
			if(!timer <= 0):
				timer -= SPEED * delta
			else:
				run = false
				timer = 0
			material.set_shader_param("timer", timer)

func _on_set_pixelate(value):
	run = true
	pixelate = value
