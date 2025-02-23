extends Node

enum DAYS{
	TUTORIAL_STAGE,
	MONDAY,
	TUESDAY,
	WEDNESDAY,
	THURSDAY,
	FRIDAY,
	ENDING_STAGE
}

var current_day = DAYS.MONDAY

var thresholds: Dictionary = {
	DAYS.MONDAY: 75,
	DAYS.TUESDAY: 125,
	DAYS.WEDNESDAY: 150,
	DAYS.THURSDAY: 180,
	DAYS.FRIDAY: 220
}

var next_day: Dictionary = {
	DAYS.TUTORIAL_STAGE: DAYS.MONDAY,
	DAYS.MONDAY: DAYS.TUESDAY,
	DAYS.TUESDAY: DAYS.WEDNESDAY,
	DAYS.WEDNESDAY: DAYS.THURSDAY,
	DAYS.THURSDAY: DAYS.FRIDAY,
	DAYS.FRIDAY: DAYS.ENDING_STAGE
}
var get_day_scene: Dictionary = {
	DAYS.TUTORIAL_STAGE: preload("res://Levels/TutorialStage.tscn"),
	DAYS.MONDAY: preload("res://Levels/Monday.tscn"),
	DAYS.TUESDAY: preload("res://Levels/Tuesday.tscn"),
	DAYS.WEDNESDAY: preload("res://Levels/Wednesday.tscn"),
	DAYS.THURSDAY: preload("res://Levels/Thursday.tscn"),
	DAYS.FRIDAY: preload("res://Levels/Friday.tscn"),
}

func get_next_scene():
	return get_day_scene[next_day[current_day]]

func restart_scene():
	return get_day_scene[current_day]

signal success
func complete_day(amt: int):
	if amt > thresholds[current_day]:
		emit_signal("success", thresholds[current_day], amt)
	else:
		emit_signal("success", thresholds[current_day], amt)


signal updated_day
func update_day(day: DAYS):
	current_day = day
	emit_signal("updated_day", current_day)
