extends Control

var clicks = 85000
var click_power = 1
var addition_time = 1  # Сколько прибавляется каждую секунду
var auto_clicks = 0    # Не используется пока

@onready var counter = $CounterLabel
@onready var timer = $Timer

func _ready():
	timer.wait_time = 10.0
	timer.timeout.connect(_on_timer_timeout)
	timer.start()
	
	update_counter()

func _on_click_button_pressed():
	clicks -= click_power
	update_counter()

func _on_timer_timeout():
	clicks += timer.wait_time
	
	if clicks < 0:
		clicks = 0
	
	update_counter()

func update_counter():
	var seconds = clicks / 1000
	var milliseconds = clicks % 1000
	counter.text = str(seconds) + "." + str(milliseconds).pad_zeros(3) + "s"
	
