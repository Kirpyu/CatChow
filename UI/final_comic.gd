extends Control

var count = 0

func _ready() -> void:
	%MainMenu.play()

func _on_button_pressed() -> void:
	match count:
		0:
			%Page1.hide()
		1:
			get_tree().change_scene_to_file("res://UI/MainMenu/main_menu.tscn")
	count += 1
