extends Node

@onready var waste = $WasteLabel
@onready var war = $WarLabel
@onready var death = $DeathLabel

@onready var bonus_sound = $BonusSound

var waste_count = 0
var war_count = 0
var death_count = 0

func add_rand_resource(amount):
	var type = randi_range(0, 2)
	ui_update(type,amount)
	bonus_sound.play()
		
func add_resource(idx,amount):
	ui_update(idx,amount)
	bonus_sound.play()
		
func ui_update(idx,amount):
	var type_name = ""
	var label = null
		
	if idx == 0:
		waste_count += amount
		waste.text = str(waste_count)
		type_name = "🗑️"
		label = waste
	elif idx == 1:
		war_count += amount
		war.text = str(war_count)
		type_name = "⚔️"
		label = war
	elif idx == 2:
		death_count += amount
		death.text = str(death_count)
		type_name = "💀"
		label = death
		
	create_floating_number(label.global_position, "+" + str(amount), type_name)	

func spend_resource(currency, amount):
	match currency:
		"waste":
			if waste_count < amount:
				return false
			waste_count -= amount
			waste.text = str(waste_count)

		"war":
			if war_count < amount:
				return false
			war_count -= amount
			war.text = str(war_count)

		"death":
			if death_count < amount:
				return false
			death_count -= amount
			death.text = str(death_count)

	return true

func create_floating_number(position, number_text, icon):
	# Создаем временную надпись
	var label = Label.new()
	label.text = icon + " " + number_text
	label.add_theme_font_size_override("font_size", 28)
	label.add_theme_color_override("font_color", Color(1, 1, 0, 1))  # Желтый
	
	# Позиционируем
	label.global_position = position - Vector2(40, 0)
	label.z_index = 100  # Поверх всего
	
	# Добавляем на сцену
	get_tree().current_scene.add_child(label)
	
	# Анимация
	var tween = create_tween()
	tween.parallel().tween_property(label, "position:y", position.y - 100, 1.2)
	tween.parallel().tween_property(label, "modulate:a", 0, 1.2)
	tween.tween_callback(label.queue_free)
