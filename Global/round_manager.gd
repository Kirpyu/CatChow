extends Node

enum DAYS{
	MONDAY,
	TUESDAY,
	WEDNESDAY,
	THURSDAY,
	FRIDAY
}

var current_day = DAYS.MONDAY

var thresholds: Dictionary = {
	DAYS.MONDAY: 200,
	DAYS.TUESDAY: 300,
	DAYS.WEDNESDAY: 500,
	DAYS.THURSDAY: 750,
	DAYS.FRIDAY: 1000
}

func complete_day(amt: int):
	if amt > thresholds[current_day]:
		day_success()
	else:
		day_failed()

func day_success():
	pass

func day_failed():
	pass
