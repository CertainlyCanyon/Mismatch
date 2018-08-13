extends Label

var Text = ""
var old_text = ""
var down = false

func _on_text_changed(new_text):
	if("COMPLETE" in new_text):
		down = false;
		get_parent().get_parent().get_node("Next").visible = true
		get_parent().get_parent().get_node("Quit").visible = true
	elif("LOSE" in new_text):
		down = false;
		get_parent().get_parent().get_node("Retry").visible = true
		get_parent().get_parent().get_node("Quit").visible = true
	elif(new_text == ""):
		down = true;
		get_parent().get_parent().get_node("Retry").visible = false
		get_parent().get_parent().get_node("Next").visible = false
		get_parent().get_parent().get_node("Quit").visible = false
		
	animate_value(Text.length(), new_text.length())
	old_text = Text
	Text = new_text
	
func animate_value(start, end):
	get_parent().get_parent().get_node("Tween").interpolate_method(self, "set_score_text", start, end, 1, Tween.TRANS_QUAD, Tween.EASE_OUT)
	get_parent().get_parent().get_node("Tween").start()
	
func set_score_text(value):
	if(down):
		text = old_text.substr(0, value)
	else:
		text = Text.substr(0, value)