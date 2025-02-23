extends Control

func _on_continue_button_pressed() -> void:
	get_tree().change_scene_to_packed(RoundManager.get_day_scene[RoundManager.DAYS.TUTORIAL_STAGE])

func _on_restart_button_pressed() -> void:
	pass # Replace with function body.

func _on_quit_button_pressed() -> void:
	get_tree().quit()
