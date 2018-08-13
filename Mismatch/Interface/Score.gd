extends Label

var score = 0

func _on_score_changed(new_score):
	animate_value(score, new_score)
	score = new_score
	
func animate_value(start, end):
	get_parent().get_parent().get_node("Tween").interpolate_method(self, "set_score_text", start, end, 1, Tween.TRANS_QUART, Tween.EASE_OUT)
	get_parent().get_parent().get_node("Tween").start()
	get_parent().get_parent().get_node("AnimationPlayer").play("Change_Score")
	
func set_score_text(value):
		if(value > score-1):
			get_parent().get_parent().get_node("AnimationPlayer").stop()
		text = "Score: " + str(round(value))