extends Control

@onready var explosion = $Explosion
@onready var end = $Label

func _ready():
	explosion.play("default")
	explosion.animation_finished.connect(_on_animation_finished)

func _on_animation_finished():
	explosion.visible = false
	end.visible = true
	var tween = create_tween()
	tween.tween_property(end, "modulate:a", 1.0, 1.0)
