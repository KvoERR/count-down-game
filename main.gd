extends Control

@onready var game = $Game
@onready var shop = $Shop

@onready var counter = $Game/CounterLabel
@onready var timer = $Game/Timer
@onready var auto_timer = $Game/AutoClickTimer


func _ready():
	timer.start()
	timer.timeout.connect(_on_timer_timeout)
	auto_timer.timeout.connect(_on_auto_timer_timeout)
	
	shop.upgrade_buy.connect(_on_upgrade_buy)

	update_ui()


func _on_click_button_pressed():
	game.click()
	update_ui()


func _on_timer_timeout():
	game.tick()
	update_ui()


func _on_auto_timer_timeout():
	game.auto_tick()
	update_ui()


func _on_upgrade_buy(data):
	if game.buy_upgrade(data):
		update_ui()


func update_ui():
	update_counter()


func update_counter():
	var seconds = game.clicks / 1000
	var milliseconds = game.clicks % 1000

	counter.text = str(seconds) + "." + str(milliseconds).pad_zeros(3) + "s"


func _on_shop_button_pressed():
	$Shop/ShopPanel.visible = true


func _on_close_button_pressed():
	$Shop/ShopPanel.visible = false
