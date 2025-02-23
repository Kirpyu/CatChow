extends Control

var _is_paused:bool = false:
	set = set_paused

func _ready() -> void:
	set_paused(false)

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		_is_paused = !_is_paused
		%ButtonPressed.play()

func pause(value:bool, input: String):
	set_paused(value)

func set_paused(value:bool) -> void:
	_is_paused = value
	get_tree().paused = _is_paused
	visible = _is_paused

func resume_game():
	_is_paused = false

func _on_continue_button_pressed() -> void:
	resume_game()
	%ButtonPressed.play()

func _on_quit_button_pressed() -> void:
	resume_game()
	get_tree().quit()
	%ButtonPressed.play()

func _on_restart_button_pressed() -> void:
	get_tree().change_scene_to_packed(RoundManager.restart_scene())
