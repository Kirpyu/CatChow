extends Control

func _ready() -> void:
	%MainMenu.play()

var count = 0
func _on_button_pressed() -> void:
	match count:
		0:
			%Page1.hide()
		1:
			%Page2.hide()
		2:
			get_tree().change_scene_to_packed(RoundManager.get_day_scene[RoundManager.DAYS.TUTORIAL_STAGE])
	count += 1
