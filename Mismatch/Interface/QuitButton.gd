extends Position2D



func _on_mouse_entered():
	get_parent().get_node("Tween").interpolate_method(get_node("button_pos"), "set_the_scale", get_node("button_pos").get_the_scale(), .25, .1, Tween.TRANS_QUAD, Tween.EASE_OUT)
	get_parent().get_node("Tween").start()
	

func _on_mouse_exited():
	get_parent().get_node("Tween").interpolate_method(get_node("button_pos"), "set_the_scale", get_node("button_pos").get_the_scale(), 0, .1, Tween.TRANS_QUAD, Tween.EASE_OUT)
	get_parent().get_node("Tween").start()

