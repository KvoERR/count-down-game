extends RigidBody2D

@export var min_speed: float = 100.0 
@export var max_speed: float = 400.0 
@export var min_lifetime: float = 3.0
@export var max_lifetime: float = 8.0

var speed: float 
var angle: float = 0.0
var center: Vector2
var radius: float = 200.0
var angular_speed: float = 1.0
var direction: int = 1

signal airplane_clicked(idx, amount)

func _ready():
	speed = randf_range(min_speed, max_speed)
	angular_speed = randf_range(0.5, 2.0)
	radius = 250
	direction = 1 if randi() % 2 == 0 else -1
	
	center = get_viewport().get_visible_rect().size / 2
	position = center  # Сам ставит себя в центр
	
	var area = $Area2D
	area.input_event.connect(_on_area_2d_input_event)
	
	var lifetime = randf_range(min_lifetime, max_lifetime)
	await get_tree().create_timer(lifetime).timeout
	queue_free()

func _physics_process(delta):
	angle += angular_speed * delta * direction
	
	var new_pos = center + Vector2(cos(angle), sin(angle)) * radius
	position = new_pos
	
	rotation = angle + PI / 2 * direction

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var points = randi_range(1, 10)
			airplane_clicked.emit(1, points)
			queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
