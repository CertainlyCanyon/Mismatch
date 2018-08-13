extends Node

const LOSE_STRING = "YOU LOSE."
const LEVEL_WIN_STRING = "LEVEL COMPLETE!"

const LEVEL_WIN_SCORE = 1000

const sound_win= preload("res://Audio/Effects/level_up.wav")
const sound_lose = preload("res://Audio/Effects/lose.wav")

var particle = preload("res://Score_Particles.tscn")

onready var sfx = get_node("SFX");

var score = 0;

onready var timer = get_node("interface/Timer")
onready var anni_timer = get_node("interface/animation_timer")

signal score_changed(score)
signal win_lose(text)
signal set_pixelate(value)

func _ready():
	get_node("Backround1").play()
	get_node("interface/AnimationPlayer").play("CountDown")
	timer.wait_time = 3
	timer.one_shot = true
	timer.start()
	anni_timer.wait_time = 4
	anni_timer.one_shot = true
	anni_timer.start()

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
	sfx.stream = sound_win
	sfx.play(0)
	get_node("interface").get_node("NextContainer").get_node("Sprite").free_children()
	pixelate()
	add_score(LEVEL_WIN_SCORE)
	win_lose(LEVEL_WIN_STRING)
	pause(true)
func lose():
	var part = particle.instance()
	add_child(part)
	part.init(Vector2(1920/2, 20));
	sfx.stream = sound_lose
	sfx.play(0)
	get_node("interface").get_node("NextContainer").get_node("Sprite").free_children()
	pixelate()
	win_lose(LOSE_STRING)
	pause(true)
func win_lose(text):
	emit_signal("win_lose", text)

func pixelate():
	emit_signal("set_pixelate", true)

func _on_RetryButton_pressed():
	set_score(0)
	get_node("Prongs").reset(3)
	emit_signal("set_pixelate", false)
	emit_signal("win_lose", "")
	get_node("interface/AnimationPlayer").stop()
	get_node("interface/AnimationPlayer").play("CountDown")
	timer.start()
	anni_timer.start()
	


func _on_NextButton_pressed():
	get_node("Prongs").reset(-1)
	emit_signal("set_pixelate", false)
	emit_signal("win_lose", "")
	get_node("interface/AnimationPlayer").stop()
	get_node("interface/AnimationPlayer").play("CountDown")
	timer.start()
	anni_timer.start()


func _on_Timer_timeout():
	pause(false)

func _on_Backround1_finished():
	get_node("Backround2").play()

func _on_Backround2_finished():
	get_node("Backround1").play()

func _on_QuitButton_pressed():
	get_tree().quit()
