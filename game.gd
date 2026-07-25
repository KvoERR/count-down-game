extends Node

@onready var earth = $Earth
@onready var label = $CounterLabel

@onready var tick_sound = $TickSound

signal bonus_achieved(amount)

var clicks = 85000
var click_power = 1
var addition_time = 1
var auto_clicks = 0

var bonus_level = 84990
var bonus_delta = 10
var resource_coef = 0.2

func auto_click():
	clicks -= auto_clicks
	if auto_clicks>0:
		create_floating_number(label.global_position, "-"+str(auto_clicks), Color(1,1,0))
	if clicks <= bonus_level:
		while bonus_level>clicks:
			bonus_achieved.emit(resource_coef)
			bonus_level -= bonus_delta
	if clicks < 0:
		clicks = 0
		game_end()
		
		
func click():
	clicks -= click_power
	create_floating_number(label.global_position+Vector2(20, 0), "-"+str(click_power), Color(0,1,0))
	if clicks <= bonus_level:
		while bonus_level>clicks:
			bonus_achieved.emit(resource_coef)
			bonus_level -= bonus_delta

	if clicks < 0:
		clicks = 0
		game_end()
		

func tick(time_to_click):
	clicks += int(time_to_click)
	create_floating_number(label.global_position+Vector2(40, 0), "+"+str(int(time_to_click)), Color(0,0,1))
	tick_sound.play()
	if clicks < 0:
		clicks = 0

func apply_upgrade(data):
	if data.type == "click":
		click_power += data.value
	else:
		auto_clicks += data.value
	
func create_floating_number(position, text, color = Color(1, 1, 1)):
	# Создаем временную надпись
	var label = Label.new()
	label.text = text
	label.add_theme_font_size_override("font_size", 28)
	label.add_theme_color_override("font_color", color)
	
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
	
func game_end():
	get_tree().change_scene_to_file("res://scenes/end.tscn")
