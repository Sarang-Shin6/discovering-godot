extends CanvasLayer

var current_message
var current_index

func update_text(message):
	if message != current_message:
		current_index = 0
		current_message = message
	
	var maxIndex = current_message.length()
	if current_index <= maxIndex:
		$Control/NinePatchRect/Label.text = current_message.substr(0, current_index)
		$TypeSound.play()
		$Timer.start()

func next():
	current_index += 1
	update_text(current_message)
	

func _on_Timer_timeout():
	next()
