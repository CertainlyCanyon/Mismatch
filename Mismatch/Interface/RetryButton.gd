extends Position2D



func _on_mouse_entered():
	get_parent().get_node("Tween").interpolate_method(self, "set_rotation", get_rotation(), -PI/4, .1, Tween.TRANS_QUAD, Tween.EASE_OUT)
	get_parent().get_node("Tween").start()

func _on_mouse_exited():
	get_parent().get_node("Tween").interpolate_method(self, "set_rotation", get_rotation(), 0, .1, Tween.TRANS_QUAD, Tween.EASE_OUT)
	get_parent().get_node("Tween").start()
