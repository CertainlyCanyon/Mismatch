extends Position2D

const MATCH_SCORE = 150
const sound_break = preload("res://Audio/Effects/break.wav")
const sound_collide = preload("res://Audio/Effects/collide.wav")

onready var sfx = get_node("SFX");

var center
var max_length = 400
var length = max_length
var shapes = []

var collision_width = 0
var collision_height = 0

var shrink_speed = 25 # this is in pixels/second
var lose_dist = 0

var pause = true

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	if(!pause):
		
		var speed = delta*(shrink_speed)
		length -= speed
		if(length <= lose_dist):
			get_node("/root/Game").lose()
		var middle = get_node("Sprite/Middle")
		get_node("Sprite/Left").scale.y = (length/3)
		get_node("Sprite/Right").scale.y = (length/3)
		middle.scale.y = (length/3)
		get_node("Sprite/Top").position.y += speed/2
		get_node("Sprite").position.y += speed/2
		get_node("Sprite/Collision").position.y -= speed/2

func init(center_obj, angle, width, distance, rad):
	# Set up prongs using different sprites for middle edges and sides so dimensions of rectangle can be controlled
	lose_dist = rad/2-distance
	center = center_obj
	var middle = get_node("Sprite/Middle")
	get_node("Sprite").position.y -= distance + length/2 - 3
	middle.scale = Vector2(width/3, length/3)
	get_node("Sprite/Top").scale.x = (width/3)
	get_node("Sprite/Left").scale.y = (length/3)
	get_node("Sprite/Right").scale.y = (length/3)
	get_node("Sprite/Left").position.x -= width/2 - 1.5
	get_node("Sprite/Right").position.x += width/2 - 1.5
	get_node("Sprite/Top").position.y -= length/2 + 1.5
	
	#set up collision for clicks
	collision_width = middle.get_texture().get_width() * middle.scale.x/2
	collision_height = middle.get_texture().get_height() * middle.scale.y/2
	get_node("Sprite/Collision").shape.set_extents(Vector2(collision_width,collision_height))
	get_node("Sprite/Collision").position.y -= 4
	
	#set rotation
	rotation = angle
	
	
	
func add_current_shape(): #add the shape the player just shot to this prong
	var new_shape = center.get_current_shape()
	#otherwise add the new shape to the list
	shapes.push_back(new_shape)
	center.next_shape(get_node("Shapes"))
	new_shape.shoot_at(self, shapes.size()-1) # tell the shape where to shoot at
	new_shape.rotation = rotation - PI/2 #because shapes need to be rotated 90 degrees to face the right way here

func _on_Sprite_input_event(viewport, event, shape_idx): # When this prong is clicked shoot the current shape to the end of it 
	if (!pause && event is InputEventMouseButton && event.pressed):
		add_current_shape()
		
func get_top_position(distance): #tells the shape where it should go to based on the distance from the end of the prong that it requests
	return (get_node("Sprite/Top").position + get_node("Sprite").position + Vector2(0, distance)).rotated(rotation)
	
func check_collision(shape, position, distance, lengthen): #check if the colliding shapes destroy eachother and if so do it and update any later shapes to drop down
		if(position > 0 && shapes.size() > position && shape.get_id() + shapes[position-1].get_id() == 0): #if the shapes combine destroy both of them
			print("here1")
			#shapes.[position+1] .queue_free()
			sfx.stream = sound_break
			sfx.play(0)
			lengthen(lengthen)
			get_node("/root/Game").add_score(MATCH_SCORE)
			var remove_shape = shapes[position-1]
			shapes.remove(position-1)
			remove_shape.kill()
			shapes.remove(position-1)
			shape.kill()
			print(shapes.size())
			for i in range(position-1, shapes.size()):
				shapes[i].shapes_removed()
		else:
			sfx.stream = sound_collide
			sfx.play(0)
			if(distance > length):
				get_node("/root/Game").lose()
		
func get_last_id():
	if(shapes.size() == 0):
		return -10
	return shapes[shapes.size()-1].get_id()
func get_length():
	return length
	
func pause(pause_bool, param):
	pause = pause_bool
	get_node("Sprite/Left").scale.y = (length/3)
	get_node("Sprite/Right").scale.y = (length/3)
	get_node("Sprite/Middle").scale.y = (length/3)
	for child in get_children():
		if(child.has_method("pause")):
			child.pause(pause_bool, param)
			
func check_win():
	center.check_win()
	
func get_speed():
	return shrink_speed
func lengthen(amount):
	var add = min(amount, max_length-length)
	length += add
	get_node("Sprite/Top").position.y -= add/2
	get_node("Sprite").position.y -= add/2
	get_node("Sprite/Collision").position.y += add/2
	for s in shapes:
		s.set_position(s.get_position() + get_top_position(10).normalized() * add)
		
