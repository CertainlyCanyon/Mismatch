extends Position2D

var the_scale = 0;

func set_the_scale(new_scale):
	the_scale  = new_scale
	scale = Vector2(1+the_scale, 1+the_scale)
	
func get_the_scale():
	return the_scale