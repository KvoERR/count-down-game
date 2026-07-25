extends Node

signal upgrade_buy(data)

const UpgradeScene = preload("res://scenes/upgrade_item.tscn")

var upgrades = [
	{
		"type": "click",
		"name": "Cut Tree",
		"desc": "+1 за клик",
		"price": 1,
		"value": 1,
		"currency": "waste"
	},
	{
		"type": "click",
		"name": "Drill Oil",
		"desc": "+5 за клик",
		"price": 100,
		"value": 5,
		"currency": "waste"
	},
		{
		"type": "click",
		"name": "Mass Consumption",
		"desc": "+5 за клик",
		"price": 100,
		"value": 5,
		"currency": "waste"
		
	},
	{
		"type": "auto",
		"name": "Factory",
		"desc": "-1/сек",
		"price": 50,
		"value": 1,
		"currency": "waste"
		
	},
	{
		"type": "auto",
		"name": "Industrial Complex",
		"desc": "-10/сек",
		"price": 500,
		"value": 10,
		"currency": "waste"
		
	},
	{
		"type": "auto",
		"name": "Megalopolis",
		"desc": "-100/сек",
		"price": 500,
		"value": 100,
		"currency": "waste"
		
	},
]

@onready var click_list = $ShopPanel/ScrollContainer/Content/Columns/ClickColumn/ClickList
@onready var auto_list = $ShopPanel/ScrollContainer/Content/Columns/AutoColumn/Autolist


func _ready():
	fill_shop()


func fill_shop():
	for i in upgrades.size():
		var upgrade = upgrades[i]

		var item = UpgradeScene.instantiate()
		item.setup(upgrade)
		item.buy_pressed.connect(_on_buy_pressed)

		var target_list

		if upgrade.type == "click":
			target_list = click_list
		else:
			target_list = auto_list

		target_list.add_child(item)

		var separator = HSeparator.new()
		separator.custom_minimum_size.y = 8
		target_list.add_child(separator)


func _on_buy_pressed(data):
	upgrade_buy.emit(data)
