extends CanvasLayer

signal score_changed(score)

func _on_score_changed(score):
	emit_signal("score_changed", score)