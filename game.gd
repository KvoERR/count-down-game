extends Node

signal bonus_achieved(amount)

var clicks = 85000
var click_power = 1
var addition_time = 1
var auto_clicks = 0

var bonus_level = 84990
var bonus_delta = 10
var resource_coef = 0.2

func click():
	clicks -= click_power
	
	if clicks <= bonus_level:
		bonus_achieved.emit(resource_coef)
		bonus_level -= bonus_delta

	if clicks < 0:
		clicks = 0


func tick(time_to_click):
	clicks += int(time_to_click)

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
