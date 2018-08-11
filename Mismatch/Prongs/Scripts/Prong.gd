extends Position2D

var center
var length = 500
var shapes = []

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func init(center_obj, angle, width, distance):
	center = center_obj
	var middle = get_node("Sprite/Middle")
	get_node("Sprite").position.y -= distance + length/2
	middle.scale = Vector2(width/3, length/3)
	get_node("Sprite/Top").scale.x = (width/3)
	get_node("Sprite/Left").scale.y = (length/3)
	get_node("Sprite/Right").scale.y = (length/3)
	get_node("Sprite/Left").position.x -= width/2 - 1.5
	get_node("Sprite/Right").position.x += width/2 - 1.5
	get_node("Sprite/Top").position.y -= length/2 + 1.5
	
	get_node("Sprite/Collision").shape.set_extents(Vector2(middle.get_texture().get_width() * middle.scale.x/2, middle.get_texture().get_height() * middle.scale.y/2))
	
	rotation = angle
	
	
	
func add_current_shape():
	var new_shape = center.get_current_shape()
	
	if(shapes.size() > 0 && new_shape.get_id() + shapes.front().get_id() == 0):
		shapes.pop_front().queue_free()
		new_shape.queue_free()
	else:
		shapes.push_front(new_shape)
		center.next_shape(get_node("Shapes"))
		new_shape.shoot_at(self)
		print(rotation)
		new_shape.rotation = rotation - PI/2

func _on_Sprite_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		print(str(name) + " : " + str(get_node("Sprite/Top").position + get_node("Sprite").position))
		add_current_shape()
		
func get_top_position(distance):
	return (get_node("Sprite/Top").position + get_node("Sprite").position + Vector2(0, distance)).rotated(rotation)
