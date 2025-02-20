extends Control

@export var lerp_speed = 0.25

var is_popped : bool = false
const _right_anchor = Vector2(1.2, 1)
const _left_anchor = Vector2(.75, 1)
var target_anchor = _right_anchor

func _process(delta: float) -> void:
	anchor_right = lerp(anchor_right, target_anchor.y, lerp_speed)
	anchor_left = lerp(anchor_left, target_anchor.x, lerp_speed)
	
	if Input.is_action_just_pressed("tab"):
		handle_button_press()


func handle_button_press():
	if is_popped:
		target_anchor = _right_anchor
	else:
		target_anchor = _left_anchor
	is_popped = !is_popped
	
func _on_texture_button_pressed() -> void:
	handle_button_press()
