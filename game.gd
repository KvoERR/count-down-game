extends Node

@onready var earth = $Earth
@onready var label = $CounterLabel

signal bonus_achieved(amount)

var clicks = 85000
var click_power = 1
var addition_time = 1
var auto_clicks = 0

var bonus_level = 84990
var bonus_delta = 10
var resource_coef = 0.2

func click():
	clicks -= click_power
	create_floating_number(label.global_position)
	if clicks <= bonus_level:
		while bonus_level>clicks:
			bonus_achieved.emit(resource_coef)
			bonus_level -= bonus_delta

	if clicks < 0:
		clicks = 0

func auto_click():
	clicks += auto_clicks
	if clicks < 0:
		clicks = 0

func tick(time_to_click):
	clicks += int(time_to_click)

	if clicks < 0:
		clicks = 0

func buy_upgrade(data):
	if clicks < data.price:
		return false

	clicks -= data.price

	if data.type == "click":
		click_power += data.value
	else:
		auto_clicks += data.value

	return true
	
func create_floating_number(position):
	# Создаем временную надпись
	var label = Label.new()
	label.text = "-1"
	label.add_theme_font_size_override("font_size", 28)
	
	# Позиционируем
	label.global_position = position + Vector2(0, 40)
	label.z_index = 100
	
	# Добавляем на сцену
	get_tree().current_scene.add_child(label)
	
	# Анимация
	var tween = create_tween()
	tween.parallel().tween_property(label, "position:y", position.y + 100, 1.2)
	tween.parallel().tween_property(label, "modulate:a", 0, 1.2)
	tween.tween_callback(label.queue_free)
