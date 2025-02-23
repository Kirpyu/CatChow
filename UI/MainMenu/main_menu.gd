extends Control

func _ready() -> void:
	%MainMenu.play()

func _on_continue_button_pressed() -> void:
	get_tree().change_scene_to_packed(load("res://UI/Comic/comic.tscn"))

func _on_restart_button_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/days.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
