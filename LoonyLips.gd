extends Control

var player_words = []
var template = [
	{
		"story": "Once upon a time someone called %s ate a %s flavoured sandwich which made him feel all %s inside. It was a %s day",
		"prompts": ["a name", "a noun", "adverb", "adjective"]
	},	
	{
		"story": "I got %s in my pocket with my %s",
		"prompts": ["a noun", "the person pronoun"]
	},
	{
		"story": "Tell my %s ain't nothing but the %s",
		"prompts": ["a name", "adjective"]
	},	
	{
		"story": "You look so %s. I want to %s",
		"prompts": ["adjective", "verb"]
	},
	{
		"story": "%s! do you know that it is not %s to %s",
		"prompts": ["a name", "adjective", "verb"]
	}
]
var current_story

onready var DisplayText = $VBoxContainer/DisplayText
onready var PlayerText = $VBoxContainer/HBoxContainer/PlayerText
onready var SubmitLabel = $VBoxContainer/HBoxContainer/Label

func _ready():
	reset_game()
	DisplayText.text = "Welcome to Loony Lips! We're going to tell a story and have a wonderful time! "
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
	current_story = template[randi() % template.size()]
	player_words.clear()


	
