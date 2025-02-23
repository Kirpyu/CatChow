extends Control

@export var coin_label: Label
@export var time_label: Label
@export var day_label: Label
@export var match_timer: Timer

var start_time = 9
var end_time = 17
var current_time = start_time
@export var duration : float = 150
var update_interval = duration / (end_time - start_time) 

func _ready() -> void:
	OrderManager.connect("gained_coins", update_coins)
	RoundManager.connect("updated_day", update_day_label)
	match_timer.wait_time = update_interval
	match_timer.start()

func update_day_label(day):
	day_label.text = RoundManager.DAYS.keys()[day]

var coins = 0
func update_coins(amt: int):
	coins += amt
	coin_label.text = "COINS: " + str(coins)

func _on_match_timer_timeout() -> void:
	current_time += 1
	if current_time > end_time:
		match_timer.stop()
		current_time = end_time
		RoundManager.complete_day(coins)
	var hour = current_time % 12
	if hour == 0: hour = 12  
	var period = "AM" if current_time < 12 else "PM"

	time_label.text = "%02d:00 %s" % [hour, period]


func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(RoundManager.get_next_scene())
