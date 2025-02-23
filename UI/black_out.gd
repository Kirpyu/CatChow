extends TextureRect

var debuffed = false
@onready var cat_eyes = %CatEyes
@export var debuff_timer : Timer
func _ready() -> void:
	RoundManager.connect("updated_day", match_day)
	
func debuff():
	debuffed = true
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 1, 0.75)
	tween.tween_callback(show_cat_eyes)
	debuff_timer.start()
	%LightsOut.play()

func _on_debuff_timer_timeout() -> void:
	debuffed = false
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 0, 0.75)
	cat_eyes.hide()
	%LightsOut.stop()

func show_cat_eyes():
	cat_eyes.show()

func match_day(day):
	if day != RoundManager.DAYS.MONDAY and day != RoundManager.DAYS.TUESDAY:
		add_to_group("debuffable")
