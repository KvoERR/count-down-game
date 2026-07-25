extends Button

func _ready():
	pressed.connect(_on_pressed)

func _on_pressed():
	var tween = create_tween()
	tween.set_parallel(true)  # Все анимации одновременно
	
	# Сжимаем кнопку
	tween.tween_property(self, "scale", Vector2(0.85, 0.85), 0.08)
	
	# Легкое смещение влево-вправо (дергание)
	tween.tween_property(self, "position:x", position.x - 5, 0.05)
	
	# Возврат
	var tween2 = create_tween()
	tween2.set_trans(Tween.TRANS_BOUNCE)
	tween2.tween_property(self, "scale", Vector2(1.0, 1.0), 0.2)
	tween2.tween_property(self, "position:x", position.x, 0.15)
