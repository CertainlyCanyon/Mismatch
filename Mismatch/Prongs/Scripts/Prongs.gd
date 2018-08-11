extends Sprite

const prong = preload("res://Prongs/Prong.tscn")
const shape = preload("res://Shapes/Shape.tscn")

var current_shape
var next_shape

var next_shape_pos =  Vector2(-500, -400)

func _ready():
	randomize()
	position = Vector2(OS.window_size.x/2, OS.window_size.y/2)
	
	current_shape = shape.instance()
	current_shape.set_active(true)
	next_shape = shape.instance()
	
	next_shape.position = next_shape_pos
	
	get_node("Shapes").add_child(current_shape)
	get_node("Shapes").add_child(next_shape)
	
	generate_prongs(8)

func _process(delta):
#	# Called every frame. Delta is time since last frame.
	pass

#spawns the prongs of the level
func generate_prongs(number):
	var angle = 0; #angle of the current prong
	var angle_add = (2*PI)/number #angle to add after each prong
	for i in range(0, number):
		var new_prong = prong.instance()
		var width = get_texture().get_width() * sin(angle_add/2) #width of the new prong to make the "square star"
		var distance = (get_texture().get_width()/2) * cos(angle_add/2) #distance away from center to have no visible gaps
		new_prong.init(self, angle, width, distance) #send all values to new prong
		angle += angle_add #add angle for next prong
		get_node("Prongs").add_child(new_prong) #add to children to keep track of it
		
func get_current_shape():
	return current_shape

func next_shape(from):
	current_shape = next_shape;
	next_shape = shape.instance()
	
	current_shape.set_active(true)
	get_node("Shapes").add_child(next_shape)
	current_shape.position = get_node("Shapes").position
	next_shape.position = next_shape_pos
	
func reparent(node, parent):
	node.get_parent().remove_child(node)
	parent.add_child(node)
	node.set_owner(parent)