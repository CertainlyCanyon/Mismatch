extends Node

const LOSE_STRING = "YOU LOSE."
const LEVEL_WIN_STRING = "LEVEL WON!"

const LEVEL_WIN_SCORE = 1000

var score = 0;

signal score_changed(score)
signal win_lose(text)
signal set_pixelate(value)

func _ready():
	pause(false)
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
func _input(event):
	if(event.is_action_pressed("ui_up")):
		add_score(50)
	if(event.is_action_pressed("ui_down")):
		win_lose(LOSE_STRING)

func pause(pause_bool):
	print("pausing")
	for child in get_children():
		if(child.has_method("pause")):
			child.pause(pause_bool, null)

func set_score(value):
	score = value
	emit_signal("score_changed", score)

func add_score(value):
	score += value
	emit_signal("score_changed", score)

func win():
	pass
func win_level():
	get_node("interface").get_node("NextContainer").get_node("Sprite").free_children()
	pixelate()
	add_score(LEVEL_WIN_SCORE)
	win_lose(LEVEL_WIN_STRING)
	pause(true)
func lose():
	get_node("interface").get_node("NextContainer").get_node("Sprite").free_children()
	pixelate()
	win_lose(LOSE_STRING)
	pause(true)
func win_lose(text):
	emit_signal("win_lose", text)

func pixelate():
	emit_signal("set_pixelate", true)

func _on_RetryButton_pressed():
	get_node("Prongs").reset(3)
	emit_signal("set_pixelate", false)
	emit_signal("win_lose", "")
	pause(false)


func _on_NextButton_pressed():
	get_node("Prongs").reset(-1)
	emit_signal("set_pixelate", false)
	emit_signal("win_lose", "")
	pause(false)
