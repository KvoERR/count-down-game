extends RigidBody2D

@export var min_speed: float = 100.0 
@export var max_speed: float = 400.0 

var speed: float 

signal asteroid_clicked(idx,amount)

func _ready():
	speed = randf_range(min_speed, max_speed)
	angular_velocity = randf_range(-2.0, 2.0)
	
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var points = randi_range(1, 10)
			asteroid_clicked.emit(0, points)
			queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
