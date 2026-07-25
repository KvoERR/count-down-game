extends Node

signal upgrade_buy(data)

const UpgradeScene = preload("res://scenes/upgrade_item.tscn")

const CURRENCIES = [
	"waste",
	"war",
	"death"
]

var upgrades = [
	{
		"type": "click",
		"name": "Cut Tree",
		"desc": "+1 per click",
		"price": 10,
		"value": 1,
		"currency": "waste"
	},
	{
		"type": "click",
		"name": "Weapons",
		"desc": "+3 per click",
		"price": 20,
		"value": 3,
		"currency": "war"
	},
	{
		"type": "click",
		"name": "Drill Oil",
		"desc": "+5 per click",
		"price": 100,
		"value": 5,
		"currency": "waste"
	},
		{
		"type": "click",
		"name": "Mass Consumption",
		"desc": "+50 per click",
		"price": 500,
		"value": 50,
		"currency": "waste"
		
	},
	{
		"type": "auto",
		"name": "Factory",
		"desc": "-1/sec",
		"price": 10,
		"value": 1,
		"currency": "waste"
		
	},
	{
		"type": "auto",
		"name": "Military Base",
		"desc": "-3/sec",
		"price": 20,
		"value": 3,
		"currency": "war"
	},
	{
		"type": "auto",
		"name": "Industrial Complex",
		"desc": "-10/sec",
		"price": 100,
		"value": 10,
		"currency": "waste"
		
	},
	{
		"type": "auto",
		"name": "Megalopolis",
		"desc": "-100/sec",
		"price": 500,
		"value": 100,
		"currency": "waste"
		
	},
]

@onready var click_list = $ShopPanel/ScrollContainer/Content/Columns/ClickColumn/ClickList
@onready var auto_list = $ShopPanel/ScrollContainer/Content/Columns/AutoColumn/Autolist

func randomize_currencies():
	var rng = RandomNumberGenerator.new()
	rng.randomize()

	for upgrade in upgrades:
		upgrade["currency"] = CURRENCIES[rng.randi_range(0, CURRENCIES.size() - 1)]
		
func _ready():
	randomize_currencies()
	fill_shop()

func fill_shop():
	for i in upgrades.size():
		var upgrade = upgrades[i]

		var item = UpgradeScene.instantiate()

		var target_list

		if upgrade.type == "click":
			target_list = click_list
		else:
			target_list = auto_list

		target_list.add_child(item)

		item.setup(upgrade)
		item.buy_pressed.connect(_on_buy_pressed)

		var separator = HSeparator.new()
		separator.custom_minimum_size.y = 8
		target_list.add_child(separator)


func _on_buy_pressed(data):
	upgrade_buy.emit(data)
