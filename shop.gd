extends Node

signal upgrade_buy(data)

const UpgradeScene = preload("res://scenes/upgrade_item.tscn")

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
		"desc": "-1/сек",
		"price": 50,
		"value": -1
	},
	{
		"type": "auto",
		"name": "Завод",
		"desc": "-10/сек",
		"price": 500,
		"value": -10
	}
]

@onready var click_list = $ShopPanel/Content/Columns/ClickColumn/ClickList
@onready var auto_list = $ShopPanel/Content/Columns/AutoColumn/Autolist


func _ready():
	fill_shop()


func fill_shop():
	for child in click_list.get_children():
		child.queue_free()

	for child in auto_list.get_children():
		child.queue_free()

	for upgrade in upgrades:
		var item = UpgradeScene.instantiate()

		item.setup(upgrade)
		item.buy_pressed.connect(_on_buy_pressed)

		if upgrade.type == "click":
			click_list.add_child(item)
		else:
			auto_list.add_child(item)


func _on_buy_pressed(data):
	upgrade_buy.emit(data)
