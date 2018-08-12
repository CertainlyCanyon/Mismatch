extends Sprite

const shape = preload("res://Shapes/Shape.tscn")

var next_shape

func next(width):
	next_shape = shape.instance()
	next_shape.init(width)
	next_shape.set_position(Vector2(next_shape.get_position().x, next_shape.get_position().y + texture.get_height()*scale.y/2))
	add_child(next_shape)
func get_shape():
	return next_shape
	
func free_children():
	remove_child(next_shape)
	next_shape.free()