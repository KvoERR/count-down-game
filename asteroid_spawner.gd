extends Node

@export var asteroid_scene: PackedScene

@export var min_delay: float = 1.0
@export var max_delay: float = 5.0

@onready var timer: Timer = $SpawnTimer

signal asteroid_clicked(idx,amount)

func _ready():
	timer.wait_time = randf_range(min_delay, max_delay)
	timer.start()
	
func spawn_asteroid():
	if asteroid_scene == null:
		return
	
	var asteroid = asteroid_scene.instantiate()
	add_child(asteroid)
	
	asteroid.position = get_random_edge_position()
	
	var target = get_viewport().get_visible_rect().size / 2
	var direction = (target - asteroid.position).normalized()
	asteroid.linear_velocity = direction * randf_range(100.0, 400.0)
	asteroid.asteroid_clicked.connect(_on_asteroid_clicked)

func _on_asteroid_clicked(idx,amount):
	asteroid_clicked.emit(idx,amount)

func get_random_edge_position() -> Vector2:
	var screen = get_viewport().get_visible_rect().size
	var side = randi() % 4
	
	match side:
		0: # Лево
			return Vector2(-50, randf_range(0, screen.y))
		1: # Право
			return Vector2(screen.x + 50, randf_range(0, screen.y))
		2: # Верх
			return Vector2(randf_range(0, screen.x), -50)
		3: # Низ
			return Vector2(randf_range(0, screen.x), screen.y + 50)
		_:
			return Vector2.ZERO

func _on_spawn_timer_timeout() -> void:
	spawn_asteroid()
	timer.wait_time = randf_range(min_delay, max_delay)
	timer.start()
