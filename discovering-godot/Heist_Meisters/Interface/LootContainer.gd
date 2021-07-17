extends NinePatchRect

func _ready():
	pass

func collect_loot():
	$VBoxContainer/ItemList.add_icon_item(load("res://GFX/Loot/suitcase.png"), false)
