extends Node

@onready var waste = $WasteLabel
@onready var war = $WarLabel
@onready var death = $DeathLabel

var waste_count = 0
var war_count = 0
var death_count = 0

func add_resource(coef):
	var type = randi_range(1, 3)
	var amount = int(coef * randi_range(1, 9))
	
	if amount>0:
	
		var type_name = ""
		var label = null
		
		if type == 1:
			waste_count += amount
			waste.text = str(waste_count)
			type_name = "🗑️"
			label = waste
		elif type == 2:
			war_count += amount
			war.text = str(war_count)
			type_name = "⚔️"
			label = war
		elif type == 3:
			death_count += amount
			death.text = str(death_count)
			type_name = "💀"
			label = death
		
		# Создаем всплывающее число
		create_floating_number(label.global_position, "+" + str(amount), type_name)

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
