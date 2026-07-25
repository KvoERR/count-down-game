extends HBoxContainer

signal buy_pressed(data)

@onready var name_label = $Info/Name
@onready var desc_label = $Info/Description
@onready var price_label = $Info/Price
@onready var buy_button = $BuyButton

var data = {}

func setup(upgrade_data):
	data = upgrade_data

	$Info/Name.text = data.name
	$Info/Description.text = data.desc
	$Info/Price.text = "Цена: " + str(data.price)

func _ready():
	buy_button.pressed.connect(_on_buy_pressed)

func _on_buy_pressed():
	buy_pressed.emit(data)
