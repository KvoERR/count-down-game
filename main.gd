extends Control

var clicks = 0

var click_power = 1

var auto_clicks = 0

@onready var counter = $CounterLabel

func _ready():
	counter.text = "Клики: 0"

func _on_click_button_pressed():
	clicks += click_power
	counter.text = "Клики: " + str(clicks)


func _on_auto_click_timer_timeout() -> void:
	pass # Replace with function body.
func _on_auto_click_timer_timeout():
	clicks += auto_clicks


func _on_shop_button_pressed() -> void:
	pass # Replace with function body.
