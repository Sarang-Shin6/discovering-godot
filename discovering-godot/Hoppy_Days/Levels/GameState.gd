extends Node2D

var lives = 3
var coins = 0

const TARGET_NUMBER_OF_COINS = 10

func _ready():
	add_to_group("GameState")
	update_GUI()

func hurt():
	lives -= 1
	$Player.hurt()
	update_GUI()
	if lives < 1:
		end_game()

func coin_up():
	coins +=1
	var multiple_of_coins = coins % TARGET_NUMBER_OF_COINS == 0
	if(multiple_of_coins):
		lives += 1
	update_GUI()

func update_GUI():
	get_tree().call_group("GUI", "update_GUI", lives, coins);

func end_game():
	get_tree().change_scene("res://Levels/GameOver.tscn")

func win_game():
	get_tree().change_scene("res://Levels/Victory.tscn")
