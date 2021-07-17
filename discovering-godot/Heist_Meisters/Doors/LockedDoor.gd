extends "res://Doors/Door.gd"

export var lock_group = "Unset"

func _ready():
	$Label.rect_rotation = -rotation_degrees
	$Label.text = lock_group

func _on_Door_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_click:
		$CanvasLayer/Numpad.popup_centered()

func _on_Door_body_exited(body):
	if body.collision_layer == 1:
		can_click = false
		$CanvasLayer/Numpad.hide()

func _on_Numpad_combination_correct():
	$CanvasLayer/Numpad.hide()
	open()

func _on_Computer_combination(numbers, group):
	if lock_group == group:
		$CanvasLayer/Numpad.combination = numbers
