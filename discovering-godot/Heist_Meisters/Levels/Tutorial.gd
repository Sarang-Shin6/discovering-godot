extends Node2D

var objective_number
var computer_turned_on = false

func _ready():
	update_pointer_positions(0)

func _process(delta):
	check_numpad_visibility()

func update_pointer_positions(number):
	objective_number = number
	
	var pointer = $ObjectiveMarker
	var place = $ObjectivePositions.get_child(objective_number)
	var message = $ObjectiveMessages.get_child(objective_number)
	
	$MessageSound.play()
	
	$Tween.interpolate_property(pointer, "position", pointer.position, place.position, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	
	$TutorialGUI.update_text(message.message)

func _on_MoveObjective_body_entered(body):
	update_pointer_positions(1)

func _on_DoorObjective_body_entered(body):
	get_tree().call_group("Interface", "set_night_vision")
	update_pointer_positions(2)

func _on_NightVisionObjective_body_entered(body):
	get_tree().call_group("Interface", "set_dark_mode")
	update_pointer_positions(3)

func _on_LootObjective_body_entered(body):
	update_pointer_positions(4)

func check_numpad_visibility():
	if objective_number == 4:
		var numpad = $Computers/Computer/CanvasLayer/ComputerPopup
		
		if numpad.visible:
			computer_turned_on = true
		
		if computer_turned_on and not numpad.visible:
			update_pointer_positions(5)

func _on_ComputerObjective_body_entered(body):
	pass

func _on_LockedDoorObjective_body_entered(body):
	update_pointer_positions(6)

