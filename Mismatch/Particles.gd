extends Particles2D

func _ready():
	var timer = get_node("Timer")
	restart()
	timer.wait_time = 10
	timer.start()
	
func init(value):
	position = value

func _on_Timer_timeout():
	queue_free();
