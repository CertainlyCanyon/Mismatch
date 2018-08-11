extends Sprite

var inlet = preload("res://Shapes/Sprites/Inlet.png")
var hole = preload("res://Shapes/Sprites/Hole.png")
var outlet = preload("res://Shapes/Sprites/Outlet.png")
var circle = preload("res://Shapes/Sprites/Circle.png")

var active = false
var target = null
var speed = 0;

var distance;

onready var TweenNode = get_node("Tween")

var id = 0

var shapes = [inlet, outlet, hole, circle]

func _ready():
	var rand = randi() % shapes.size();
	var shape_tex = shapes[rand]
	set_texture(shape_tex)
	
	if(rand == 0):
		id = -1
	elif(rand == 3):
		id = -2
	else:
		id = rand
		
	distance = texture.get_height()/2

func _process(delta):
	if(active):
		var mouse = get_viewport().get_mouse_position()
		look_at(mouse)
	if(speed != 0):
		var top = target.get_top_position(distance)
		var vector = (top - position)
		var motion_vector = vector.normalized()
		speed += 80
		if(vector.length() < 50):
			print("stop")
			position = top
			speed = 0
		position += motion_vector * speed * delta
		#position = target.position
		
	
func shoot_at(object):
	target = object
	speed = 1000
	active = false
	
func get_id():
	return id
func set_active(new):
	active = new