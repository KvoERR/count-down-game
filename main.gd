extends Control

const UpgradeScene = preload("res://scenes/upgrade_item.tscn")

var clicks = 85000
var click_power = 1
var addition_time = 1
var auto_clicks = 0

var upgrades = [
	{
		"type": "click",
		"name": "Палец",
		"desc": "+1 за клик",
		"price": 10,
		"value": 1
	},
	{
		"type": "click",
		"name": "Молот",
		"desc": "+5 за клик",
		"price": 100,
		"value": 5
	},
	{
		"type": "auto",
		"name": "Робот",
		"desc": "+1/сек",
		"price": 50,
		"value": -1
	},
	{
		"type": "auto",
		"name": "Завод",
		"desc": "+10/сек",
		"price": 500,
		"value": -10
	}
]

@onready var counter = $CounterLabel
@onready var timer = $Timer

# Пути должны соответствовать main.tscn
@onready var click_list = $ShopPanel/Content/Columns/ClickColumn/ClickList
@onready var auto_list = $ShopPanel/Content/Columns/AutoColumn/Autolist

func _ready():
	timer.wait_time = 10.0
	timer.timeout.connect(_on_timer_timeout)
	timer.start()

	fill_shop()
	update_ui()
	update_counter()


func _on_click_button_pressed():
	clicks -= click_power

	if clicks < 0:
		clicks = 0

	update_ui()
	update_counter()


func _on_timer_timeout():
	clicks += addition_time

	if clicks < 0:
		clicks = 0

	update_ui()
	update_counter()


func update_counter():
	var seconds = clicks / 1000
	var milliseconds = clicks % 1000
	counter.text = str(seconds) + "." + str(milliseconds).pad_zeros(3) + "s"


func update_ui():
	update_counter()


func fill_shop():
	for upgrade in upgrades:
		var item = UpgradeScene.instantiate()

		item.setup(upgrade)
		item.buy_pressed.connect(_on_upgrade_buy)

		if upgrade.type == "click":
			click_list.add_child(item)
		else:
			auto_list.add_child(item)


func _on_auto_click_timer_timeout():
	clicks += auto_clicks
	update_ui()


func _on_shop_button_pressed():
	$ShopPanel.visible = true


func _on_close_button_pressed():
	$ShopPanel.visible = false


func _on_upgrade_buy(data):
	print("Куплено:", data.name)

	if clicks < data.price:
		return

	clicks -= data.price

	if data.type == "click":
		click_power += data.value
	else:
		auto_clicks += data.value

	update_ui()
