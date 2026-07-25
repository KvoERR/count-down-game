extends Node

var clicks = 85000
var click_power = 1
var addition_time = 1
var auto_clicks = 0

func click():
	clicks -= click_power

	if clicks < 0:
		clicks = 0


func tick():
	clicks += addition_time

	if clicks < 0:
		clicks = 0


func auto_tick():
	clicks += auto_clicks
	if clicks < 0:
		clicks = 0


func buy_upgrade(data):
	if clicks < data.price:
		return false

	clicks -= data.price

	if data.type == "click":
		click_power += data.value
	else:
		auto_clicks += data.value

	return true
