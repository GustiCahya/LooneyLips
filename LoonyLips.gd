extends Control

var player_words = []
var story = "Once upon a time %s watched %s and thought it was the %s movie of the past two decades"
var prompts = ["Yann", "Minions", "greatest"]

onready var DisplayText = $VBoxContainer/DisplayText
onready var PlayerText = $VBoxContainer/HBoxContainer/PlayerText

func _ready():
	DisplayText.text = story % prompts

func _on_PlayerText_text_entered(new_text):
	update_DisplayText()

func _on_TextureButton_pressed():
	update_DisplayText()

func update_DisplayText():
	var new_text = PlayerText.text
	if !new_text:
		return
	DisplayText.text = new_text
	PlayerText.clear()
	
func add_to_player_words():
	player_words.append()
	
