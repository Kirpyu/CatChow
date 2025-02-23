extends TextureProgressBar
class_name Bar

@export var timer: Timer

func _ready() -> void:
	max_value = timer.wait_time

func _physics_process(delta: float) -> void:
	if timer.is_stopped():
		hide()
	else:
		show()
		value = max_value - timer.time_left
