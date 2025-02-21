extends Area2D
class_name Counter

@export var counter_name : String
@export var work_timer : Timer
@export var animated_sprite : AnimatedSprite2D

func entered():
	print("Hello")
	
func get_counter_name() -> String:
	return counter_name

func error_message():
	print("error: aint the right shit brother")
	
func working_message():
	pass

func _on_body_entered(player: Player) -> void:
	player.update_counter(self)


func _on_body_exited(player: Player) -> void:
	player.remove_counter()

func do_task() -> void:
	print("Doing Task! Item Counter: " + counter_name)

func _on_work_timer_timeout() -> void:
	pass
