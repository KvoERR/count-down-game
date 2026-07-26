extends Area2D

@onready var click_sound = $ClickSound

# СИГНАЛ ДЛЯ ПЕРЕДАЧИ КЛИКА
signal clicked

func _ready():
	input_pickable = true
	input_event.connect(_on_input_event)

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			click_sound.play()
			
			var tween = create_tween()
			tween.set_parallel(true)
			tween.tween_property(self, "scale", Vector2(0.85, 0.85), 0.08)
			tween.tween_property(self, "position:x", position.x - 5, 0.05)
			
			var tween2 = create_tween()
			tween2.set_trans(Tween.TRANS_BOUNCE)
			tween2.tween_property(self, "scale", Vector2(1.0, 1.0), 0.2)
			tween2.tween_property(self, "position:x", position.x, 0.15)
			
			clicked.emit()
