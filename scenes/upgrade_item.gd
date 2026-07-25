extends HBoxContainer

signal buy_pressed(data)

@onready var name_label = $Info/Name
@onready var desc_label = $Info/Description
@onready var price_label = $Info/Price
@onready var buy_button = $BuyButton

var data = {}

func setup(upgrade_data):
	data = upgrade_data

	name_label.text = data.name
	desc_label.text = data.desc

	var icon = ""

	match data.currency:
		"waste":
			icon = "🗑️"
		"war":
			icon = "⚔️"
		"death":
			icon = "💀"
		_:
			icon = "❓"

	price_label.text = icon + " " + str(data.price)

func _ready():
	buy_button.pressed.connect(_on_buy_pressed)

func _on_buy_pressed():
	buy_pressed.emit(data)
