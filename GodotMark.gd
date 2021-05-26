extends Node2D

class Mover:
	var position := Vector2(5, 5)
	var velocity := Vector2.ZERO
	var texture: Texture = preload("res://icon.png")

var movers := []

export var instances := 1000
export var speed := 1000.0

onready var label := $CanvasLayer/Label

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		spawn_movers()


func spawn_movers():
	for i in instances:
		var mover = Mover.new()
		mover.velocity = Vector2(rand_range(-1, 1), rand_range(-1, 1))
		movers.append(mover)


func _process(delta: float) -> void:
	for mover in movers:
		mover.position += mover.velocity * speed * delta

		if mover.position.x < 0 or mover.position.x > 1024:
			mover.velocity.x = -mover.velocity.x

		if mover.position.y < 0 or mover.position.y > 600:
			mover.velocity.y = -mover.velocity.y

	label.text = "FPS: %d\nMovers: %d" % [Engine.get_frames_per_second(), movers.size()]
	update()


func _draw() -> void:
	for mover in movers:
		draw_texture(mover.texture, mover.position)
