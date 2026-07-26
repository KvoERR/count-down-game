extends Control

@onready var game = $Game
@onready var interface = $Interface
@onready var shop = $Shop
@onready var asteroid_spawner = $Game/AsteroidSpawner

@onready var counter = $Game/CounterLabel
@onready var timer = $Game/Timer
@onready var auto_timer = $Game/AutoClickTimer

@onready var click_stats = $Game/ClickStats
@onready var auto_stats = $Game/AutoStats

@onready var shop_button = $Game/ShopButton

@onready var animated_bg = $Background
@onready var earth = $Game/Earth

@onready var shop_sound = $ShopSound

func _ready():
	animated_bg.play("default")
	timer.start()
	timer.timeout.connect(_on_timer_timeout)
	auto_timer.timeout.connect(_on_auto_timer_timeout)
	
	earth.clicked.connect(_on_click_button_pressed)
	game.bonus_achieved.connect(_on_bonus_achieved)
	asteroid_spawner.asteroid_clicked.connect(_on_event_clicked)
	
	shop.upgrade_buy.connect(_on_upgrade_buy)
	
	update_ui()

func _on_click_button_pressed():
	game.click()
	update_ui()

func _on_timer_timeout():
	game.tick(timer.wait_time)
	update_ui()


func _on_auto_timer_timeout():
	game.auto_click()
	update_ui()

func _on_bonus_achieved(amount):
	interface.add_rand_resource(amount)
	
func _on_event_clicked(idx,amount):
	interface.add_resource(idx,amount)

func _on_upgrade_buy(data):
	if interface.spend_resource(data.currency, data.price):
		game.apply_upgrade(data)
		shop_sound.play()
		update_ui()
		
func update_stats():
	click_stats.text = " " + str(game.click_power)
	auto_stats.text = " " + str(-game.auto_clicks) + "/sec"
	

func update_ui():
	update_counter()
	update_stats()

func update_counter():
	var seconds = game.clicks / 1000
	var milliseconds = game.clicks % 1000

	counter.text = str(seconds) + "." + str(milliseconds).pad_zeros(3) + "s"

func _on_shop_button_pressed():
	shop_button.visible = false
	$Shop/ShopPanel.visible = true
	earth.input_pickable = false 
	shop_sound.play()

func _on_close_button_pressed():
	$Shop/ShopPanel.visible = false
	shop_button.visible = true
	earth.input_pickable = true
