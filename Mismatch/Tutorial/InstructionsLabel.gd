extends Label

const prongs = preload("res://Prongs/Prongs.tscn")

const instructions = ["Welcome to Mismatch! Click anywhere to progress through the tutorial or click \"Skip Tutoraial\" if you know what you're doing,",
 "This is the game level...",
"To play you shoot shapes down the troughs coming out from the center, currently there are 3.",
"You always shoot the shape that is in the middle of the level. Try shooting it now by clicking on one of the troughs.",
"Great work! You will also be able to see the next shape that is on deck to come into the center.",
"In the game the troughs will be shrinking towords you, and when the end of the trough or the closest shape reaches the middle you will lose.",
"shooting a shape at a trough will increase it's length a little bit, and destroying blocks will increase it alot.",
"When you shoot the triangle at the concave shape or the other way around they will both be destroyed. Same with the circle and the square with a hole in it.",
"To beat the level and progress you must match the shapes closest to the center on every prong",
"Get ready to play!",
""]

onready var game = get_parent().get_parent().get_parent()

var instruction = 0

var center

var Text = ""

func _ready():
	set_instruction(instruction)

func handle(number):
	match number:
		1:
			center = prongs.instance()
			game.add_child(center)
			center.pause(true, null)
		3:
			center.set_prong_speed(0)
			center.pause(false, null)
		4:
			center.pause(true, false)
			get_node("Timer2").wait_time = .5
			get_node("Timer2").one_shot = true
			get_node("Timer2").start()
		5:
			game.get_node("interface/NextContainer").visible = true
		6:
			center.set_prong_speed(25)
			get_node("Timer").wait_time = 2
			get_node("Timer").one_shot = true
			get_node("Timer").start()
		10:
			get_tree().change_scene("res://Game.tscn")

func check(number):
	match number:
		4:
			if(game.get_node("interface/NextContainer/Sprite").shapes > 1):
				return true
			else:
				return false
	return true
func _process(delta):
	if(Input.is_action_just_pressed("click")):
		if(check(instruction)):
			set_instruction(instruction)

func set_instruction(number):
	handle(number)
	instruction +=1
	text = ""
	Text = instructions[number]
	animate_value(text.length(), Text.length())

func animate_value(start, end):
	get_node("Tween").interpolate_method(self, "set_score_text", start, end, .5, Tween.TRANS_QUAD, Tween.EASE_OUT)
	get_node("Tween").start()
	
func set_score_text(value):
		text = Text.substr(0, value)
		

func _on_Timer_timeout():
	center.set_prong_speed(25)


func _on_Timer2_timeout():
	center.pause(true, null)


func _on_Skip_Button_pressed():
	get_tree().change_scene("res://Game.tscn")
