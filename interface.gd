extends Node

@onready var waste = $WasteLabel
@onready var war = $WarLabel
@onready var death = $DeathLabel

var waste_count = 0
var war_count = 0
var death_count = 0

func add_resource(coef):
	var type = randi_range(1, 3)
	print("Тип ресурса: ", type)
	
	var amount = int(coef * randi_range(1, 9))
	print("Количество: ", amount)
	
	if type == 1:
		waste_count += amount
		waste.text = str(waste_count)
		print("Добавлен ресурс WASTE: ", waste_count)
	elif type == 2:
		war_count += amount
		war.text = str(war_count)
		print("Добавлен ресурс WAR: ", war_count)
	elif type == 3:
		death_count += amount
		death.text = str(death_count)
		print("Добавлен ресурс DEATH: ", death_count)
