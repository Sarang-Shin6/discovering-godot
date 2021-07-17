extends ColorRect

func _on_Area2D_body_entered(body):
	if body.has_node("Briefcase"):
		get_tree().change_scene("res://Levels/Victory Screen.tscn")
