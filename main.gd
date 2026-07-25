extends Control

var clicks = 0

@onready var counter = $CounterLabel

func _ready():
	counter.text = "Клики: 0"

func _on_click_button_pressed():
	clicks += 1
	counter.text = "Клики: " + str(clicks)
