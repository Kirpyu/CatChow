extends Control

func _ready() -> void:
	RoundManager.connect("success", complete_day)
	set_paused(false)
	
var _is_paused:bool = false:
	set = set_paused

func pause(value:bool):
	set_paused(value)

func complete_day(threshold, amt):
	print("ran")
	set_paused(true)
	if threshold > amt:
		%MainHeading.text = "FAILED!" 
	else:
		%MainHeading.text = "SURVIVED!" 
	%SubHeading.text = "Gold Gained: " + str(amt) + "\nQuota: " + str(threshold)

func set_paused(value:bool) -> void:
	_is_paused = value
	get_tree().paused = _is_paused
	visible = _is_paused

func resume_game():
	_is_paused = false

func _on_continue_button_pressed() -> void:
	get_tree().change_scene_to_packed(RoundManager.get_next_scene())
	%ButtonPressed.play()

func _on_quit_button_pressed() -> void:
	resume_game()
	get_tree().quit()
	%ButtonPressed.play()

func _on_restart_button_pressed() -> void:
	get_tree().change_scene_to_packed(RoundManager.restart_scene())
