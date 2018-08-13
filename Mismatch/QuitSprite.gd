extends Sprite

func set_move(val):
	modulate.a = round(255*val)
	scale = Vector2(val, val)
