extends Control

var first_play : bool = true
var player_words = []
var current_story : Dictionary

onready var DisplayText = $VBoxContainer/DisplayText
onready var PlayerText = $VBoxContainer/HBoxContainer/PlayerText
onready var SubmitLabel = $VBoxContainer/HBoxContainer/Label

func _ready():
	reset_game()
	refresh_scene()
	PlayerText.grab_focus()

func _on_PlayerText_text_entered(new_text):
	add_to_player_words()

func _on_TextureButton_pressed():
	add_to_player_words()
	
func add_to_player_words():
	var new_text = PlayerText.text
	if new_text:
		player_words.append(new_text)
		PlayerText.clear()
		refresh_scene()
	else:
		refresh_scene()
	
func is_story_done():
	return player_words.size() == current_story.prompts.size()

func refresh_scene():
	if is_story_done():
		show_result()
	else:
		show_question()

func show_question():
	if (first_play):
		DisplayText.text = "Welcome to Loony Lips! We're going to tell a story and have a wonderful time! "
		first_play = false
	else :
		DisplayText.text = ""
	DisplayText.text += "May I have " + current_story.prompts[player_words.size()] + " please?"
	PlayerText.show()
	SubmitLabel.text = "Ok"

func show_result():
	DisplayText.text = current_story.story % player_words
	PlayerText.hide()
	SubmitLabel.text = "Again!"
	reset_game()

func reset_game():
	randomize()
#	JSON Method
	var stories = read_json_file("StoryBook.json")
	current_story = stories[randi() % stories.size()]
	player_words.clear()
#	Node Method
#	var count_stories = $StoryBook.get_child_count()
#	var index_story = randi() % count_stories
#	current_story.prompts = $StoryBook.get_child(index_story).prompts
#	current_story.story = $StoryBook.get_child(index_story).story
#	player_words.clear()

func read_json_file(filename):
	var file = File.new()
	file.open(filename, file.READ)
	var text = file.get_as_text()
	var json_data = parse_json(text)
	file.close()
	return json_data


	
