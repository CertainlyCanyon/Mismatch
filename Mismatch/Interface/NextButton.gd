extends Position2D

var position_x

func _ready():
	position_x = position.x

func _on_mouse_entered():
	get_parent().get_node("Tween").interpolate_method(self, "set_x", position.x, position_x + 30, .1, Tween.TRANS_QUAD, Tween.EASE_OUT)
	get_parent().get_node("Tween").start()

func _on_mouse_exited():
	get_parent().get_node("Tween").interpolate_method(self, "set_x", position.x, position_x, .1, Tween.TRANS_QUAD, Tween.EASE_OUT)
	get_parent().get_node("Tween").start()

func set_scale(s):
	scale = s
func set_x(x):
	position.x = x
