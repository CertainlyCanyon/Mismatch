extends Sprite

const prong = preload("res://Prongs/Prong.tscn")
const shape = preload("res://Shapes/Shape.tscn")

var number_of_prongs = 3
var width
var pause = true

var timer = 0

var shape_width = 0

var current_shape

var next_box

func reset(number):
	if(current_shape != null):
		current_shape.get_parent().remove_child(current_shape)
		current_shape.free()
	for p in get_node("Prongs").get_children():
		p.queue_free()
		
	for s in get_node("Shapes").get_children():
		s.free()
	
	if number == -1:
		number_of_prongs += 1
	else:
		number_of_prongs = number
	
	width = get_texture().get_width() * sin(PI/number_of_prongs) #width of the new prong to make the "square star"
	
	current_shape = create_shape()
	current_shape.set_active(true)
	current_shape.pause(true, null)
	
	next_box = get_parent().get_node("interface").get_node("NextContainer").get_node("Sprite")
	next_box.next(width)
	
	generate_prongs(number_of_prongs)

func _ready():
	randomize()
	position = Vector2(OS.window_size.x/2, OS.window_size.y/2)
	
	reset(number_of_prongs)
	
func _process(delta):
	# Called every frame. Delta is time since last frame.
	if(!pause && number_of_prongs > 3):
		timer += delta*4
		scale.x = abs(sin(timer))/16 + 1
		scale.y = abs(sin(timer))/16 + 1
	#rotation += .01
	pass

#spawns the prongs of the level
func generate_prongs(number):
	var angle = 0; #angle of the current prong
	var angle_add = (2*PI)/number_of_prongs #angle to add after each prong
	for i in range(0, number):
		var new_prong = prong.instance()
		var distance = (get_texture().get_width()/2) * cos(angle_add/2) #distance away from center to have no visible gaps
		new_prong.init(self, angle, width, distance, get_texture().get_width()) #send all values to new prong
		angle += angle_add #add angle for next prong
		get_node("Prongs").add_child(new_prong) #add to children to keep track of it
		
func get_current_shape():
	return current_shape

func next_shape(from): #releases current node to a prong and rotates the next node in
	current_shape = next_box.get_shape();
	reparent(current_shape, self)
	next_box.next(width)
	
	if(!weakref(current_shape).get_ref()):
		current_shape = create_shape()
	current_shape.set_active(true)
	current_shape.position = get_node("Shapes").position
	
func reparent(node, parent): # re-parents a shape to the prong it was shot at
	node.get_parent().remove_child(node)
	parent.add_child(node)
	node.set_owner(parent)
	
func create_shape():
	var n_shape = shape.instance()
	shape_width = n_shape.init(width)
	get_node("Shapes").add_child(n_shape)
	return n_shape
	
func check_win():
	var prongs = get_node("Prongs").get_children()
	var id = prongs[0].get_last_id()
	if(id == -10):
		return
	for p in range(1, prongs.size()):
		if(prongs[p].get_last_id() != id):
			return
	
	#win
	get_node("/root/Game").win_level()

func pause(pause_bool, param):
	pause = pause_bool
	if(param == false):
		current_shape.pause(true, null)
	else:
		for child in get_children():
			if(child.has_method("pause")):
				child.pause(pause_bool, param)
			
func set_prong_speed(speed):
	for p in get_node("Prongs").get_children():
		p.shrink_speed = speed