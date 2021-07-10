extends Popup

var combination = [0,4,5,1]
var guess = []

onready var display = $VBoxContainer/DisplayContainer/Display
onready var light = $VBoxContainer/ButtonContainer/GridContainer/StatusLight

signal combination_correct

func _ready():
	connect_buttons()

func connect_buttons():
	for child in $VBoxContainer/ButtonContainer/GridContainer.get_children():
		if child is Button:
			child.connect("pressed", self, "Button_pressed", [child.text])

func Button_pressed(button):
	if button == "OK":
		check_guess()
	else:
		enter(int(button))

func check_guess():
	if guess == combination:
		open()
	else:
		reset_lock()

func open():
	light.texture = load("res://GFX/Interface/PNG/dotGreen.png")
	$Timer.start()
	$AudioStreamPlayer.stream = load("res://SFX/threeTone1.ogg")
	$AudioStreamPlayer.play()

func enter(button):
	$AudioStreamPlayer.stream = load("res://SFX/twoTone1.ogg")
	$AudioStreamPlayer.play()
	guess.append(button)
	update_display()

func update_display():
	display.text = PoolStringArray(guess).join("")

func reset_lock():
	light.texture = load("res://GFX/Interface/PNG/dotRed.png")
	guess.clear()
	update_display()	

func _on_Timer_timeout():
	emit_signal("combination_correct")
	reset_lock()
