extends Control

func _ready() -> void:
	%MainMenu.play()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/Monday.tscn")


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/Tuesday.tscn")

func _on_button_3_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/Wednesday.tscn")


func _on_button_4_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/Thursday.tscn")


func _on_button_5_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/Friday.tscn")


func _on_button_6_pressed() -> void:
	get_tree().change_scene_to_packed(load("res://UI/MainMenu/main_menu.tscn"))
