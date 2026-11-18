extends Node2D

@export var speed: float = 300.0

func _process(delta: float) -> void:
	var direction: float = Input.get_axis("move_left", "move_right")
	position.x += direction * speed * delta
	position.x = clampf(position.x, 25.0, 1127.0)

func _draw() -> void:
	draw_circle(Vector2.ZERO, 25.0, Color(0.2, 0.55, 1.0))
	draw_circle(Vector2(-8, -6), 3.0, Color.WHITE)
	draw_circle(Vector2(8, -6), 3.0, Color.WHITE)
