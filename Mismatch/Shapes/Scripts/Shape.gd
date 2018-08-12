extends Sprite

const SHAPE_SCORE = 50

var inlet = preload("res://Shapes/Sprites/Inlet.png")
var hole = preload("res://Shapes/Sprites/Hole.png")
var outlet = preload("res://Shapes/Sprites/Outlet.png")
var circle = preload("res://Shapes/Sprites/Circle.png")

var active = false
var target = null
var speed = -1;

var pause = false

var distance;
var stack_pos;

onready var TweenNode = get_node("Tween")

var id = 0

var shapes = [inlet, outlet, hole, circle]

#func _ready():
	#pass

func init(width):
	var rand = randi() % shapes.size();
	var shape_tex = shapes[rand]
	set_texture(shape_tex)
	
	if(rand == 0):
		id = -1
	elif(rand == 3):
		id = -2
	else:
		id = rand
		
	scale *= width/texture.get_width()
	distance = (texture.get_height()*scale.y)/2
	return scale

func _process(delta):
	#print(target)
	if(str(target)=="[Deleted Object]"):
		free()
	else:
		if(!pause):
			if(active): # if this shape is being shot, look at the mouse
				var mouse = get_viewport().get_mouse_position()
				look_at(mouse)
			if(speed > 0): # if its moving ask where to move to and accelerat there
				var top = target.get_top_position(distance) # + texture.get_height()/2
				var vector = (top - position)
				var motion_vector = vector.normalized()
				speed += 80
				if(vector.length() < 50): #stop when it gets close
					position = top
					speed = 0
					target.lengthen(texture.get_height()*scale.y)
					get_node("/root/Game").add_score(SHAPE_SCORE)
					var remove = target.check_collision(self, stack_pos, distance, texture.get_height()*scale.y)
					target.check_win()
				position += motion_vector * speed * delta
				#position = target.position
			elif(speed != -1):
				position -= target.get_top_position(distance).normalized() * target.get_speed() * delta
				if(distance  + texture.get_height()*scale.y/2 > target.get_length()):
					get_node("/root/Game").lose()
			
	
func shoot_at(object, number): # sets the prong this shape was shot at and sets the distance from the end
	stack_pos = number
	distance += texture.get_height() * scale.y * number
	target = object
	speed = 1000
	active = false
	
func get_id():
	return id
func set_active(new):
	active = new
	
func pause(pause_bool, param):
	pause = pause_bool
	for child in get_children():
		if(child.has_method("pause")):
			child.pause(pause_bool, param)
			
func shapes_removed():
	distance -= texture.get_height()*scale.y*2
	speed = 80