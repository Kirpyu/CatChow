extends Area2D
class_name Counter

@export var counter_name : String

func entered():
	print("Hello")

func get_counter_name() -> String:
	return counter_name


func _on_body_entered(player: Player) -> void:
	player.update_counter(self)


func _on_body_exited(player: Player) -> void:
	player.remove_counter()
