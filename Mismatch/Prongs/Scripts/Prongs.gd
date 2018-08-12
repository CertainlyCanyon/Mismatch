extends Sprite

const prong = preload("res://Prongs/Prong.tscn")
const shape = preload("res://Shapes/Shape.tscn")

var number_of_prongs = 4
var width
var pause = false

var current_shape
var next_shape

var next_shape_pos =  Vector2(-500, -400)

func _ready():
	randomize()
	position = Vector2(OS.window_size.x/2, OS.window_size.y/2)
	
	width = get_texture().get_width() * sin(PI/number_of_prongs) #width of the new prong to make the "square star"
	
	current_shape = create_shape()
	current_shape.set_active(true)
	next_shape = create_shape()
	next_shape.position = next_shape_pos
	
	generate_prongs(number_of_prongs)

func _process(delta):
	# Called every frame. Delta is time since last frame.
	if(!pause):
		pass
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
	current_shape = next_shape;
	next_shape = create_shape()
	
	if(!weakref(current_shape).get_ref()):
		current_shape = create_shape()
	current_shape.set_active(true)
	current_shape.position = get_node("Shapes").position
	next_shape.position = next_shape_pos
	
func reparent(node, parent): # re-parents a shape to the prong it was shot at
	node.get_parent().remove_child(node)
	parent.add_child(node)
	node.set_owner(parent)
	
func create_shape():
	var n_shape = shape.instance()
	n_shape.init(width)
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
	for child in get_children():
		if(child.has_method("pause")):
			child.pause(pause_bool, param)