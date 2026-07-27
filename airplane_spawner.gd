extends Node

@export var airplane_scene: PackedScene

@export var min_delay: float = 15.0
@export var max_delay: float = 55.0

@onready var timer: Timer = $SpawnTimer

signal airplane_clicked(idx, amount)

func _ready():
	timer.wait_time = randf_range(min_delay, max_delay)
	timer.start()
	
func spawn_airplane():
	if airplane_scene == null:
		return
	
	var airplane = airplane_scene.instantiate()
	add_child(airplane)
	
	# НЕ ЗАДАЁМ ПОЗИЦИЮ! Самолёт сам поставит себя в центр
	airplane.airplane_clicked.connect(_on_airplane_clicked)

func _on_airplane_clicked(idx, amount):
	airplane_clicked.emit(idx, amount)

func _on_spawn_timer_timeout() -> void:
	spawn_airplane()
	timer.wait_time = randf_range(min_delay, max_delay)
	timer.start()
