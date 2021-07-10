extends CanvasModulate

const DARK = Color("111111")
const NIGHT_VISION = Color("37bf62")

var cooldown = false

func _ready():
	visible = true
	color = DARK

func cycle_vision_mode():
	if not cooldown:
		set_vision_and_sound()
		start_cooldown()

func set_vision_and_sound():
	if color == DARK:
		color = NIGHT_VISION
		setAudio(load("res://SFX/nightvision.wav"))
		get_tree().call_group("lights", "hide")
		get_tree().call_group("labels", "show")
	else:
		color = DARK
		setAudio(load("res://SFX/nightvision_off.wav"))
		get_tree().call_group("lights", "show")
		get_tree().call_group("labels", "hide")

func setAudio(audioStream):
	$AudioStreamPlayer2D.stream = audioStream
	$AudioStreamPlayer2D.play()

func start_cooldown():
	cooldown = true
	$Timer.start()

func _on_Timer_timeout():
	cooldown = false
