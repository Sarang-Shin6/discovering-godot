extends Control

var player_words = [];
var current_story = {};

onready var PlayerText_node = $"VBoxContainer/HBoxContainer/PlayerText";
onready var DisplayText_node = $"VBoxContainer/DisplayText";
onready var ButtonLabel_node = $"VBoxContainer/HBoxContainer/ButtonLabel";

func _ready():
	set_current_story();
	DisplayText_node.text = "Welcome to Loony Lips! We're going to tell a story and have a wonderful time!  "
	PlayerText_node.hide();
	ButtonLabel_node.text = "Start!"

func start_game():
	ButtonLabel_node.text = "OK!";
	PlayerText_node.show();
	PlayerText_node.grab_focus();
	check_player_words_length();

func set_current_story():
	randomize();
	get_random_story_object();
#	get_random_story_json();

func get_random_story_object():
	var selected_story = $"StoryBook".get_child(randi() % $"StoryBook".get_child_count());
	current_story.prompts = selected_story.prompts;
	current_story.story = selected_story.story;

func get_random_story_json():
	var stories = get_from_json("StoryBook.json");
	current_story = stories[randi() % stories.size()];

func get_from_json(filename):
	var file = File.new();
	file.open(filename, File.READ);
	var text = file.get_as_text();
	var data = parse_json(text);
	file.close();
	return data;

func _on_PlayerText_text_entered(new_text):
	add_to_player_words();

func _on_TextureButton_pressed():
	if is_first_prompt():
		start_game();
	elif is_story_done():
		get_tree().reload_current_scene();
	else:
		add_to_player_words();
	
func add_to_player_words():
	player_words.append(PlayerText_node.text);
	DisplayText_node.text = "";
	PlayerText_node.clear();
	check_player_words_length();
	PlayerText_node.grab_focus();

func check_player_words_length():
	if is_story_done():
		end_game();
	else:
		prompt_player();

func is_story_done():
	return player_words.size() == current_story.prompts.size();

func is_first_prompt():
	return player_words.size() < 1 && PlayerText_node.visible == false;

func prompt_player():
	DisplayText_node.text =  "May I have " + current_story.prompts[player_words.size()] + " please?";

func end_game():
	PlayerText_node.queue_free();
	ButtonLabel_node.text = "Again!";
	tell_story();

func tell_story():
	DisplayText_node.text = current_story.story % player_words;
