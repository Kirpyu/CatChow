extends Control

signal gained_money

var order_slips: Array[OrderSlip] = []
var starting_pos = Vector2(75,200)
var slip_amt = 0
@export var slip_timer : Timer
@export var slips: Control
var base_slip_timer : float
var current_day : RoundManager.DAYS

func _ready() -> void:
	OrderManager.connect("added_order", add_slip)
	OrderManager.connect("completed_order", complete_slip)
	RoundManager.connect("updated_day", update_day)
	base_slip_timer = slip_timer.wait_time

func add_slip(order: Order):
	var temp_slip: OrderSlip = load("res://UI/OrderSlip/order_slip.tscn").instantiate()
	temp_slip.order = order
	temp_slip.set_position(Vector2(starting_pos.x + (300 * slip_amt), starting_pos.y))
	slip_amt += 1
	slips.add_child(temp_slip)
	order_slips.push_back(temp_slip)

func complete_slip(arr: Array, index: int):
	var temp: OrderSlip = order_slips.pop_at(index)
	OrderManager.gain_coins(randi_range(temp.order.value - 5, temp.order.value + 5))
	if temp.order.order == arr:
		temp.queue_free()
		slip_amt -= 1
		rearrange_slips(index)
	else:
		error_message()

func rearrange_slips(index):
	if !order_slips:
		return
	if index - 1 == order_slips.size():
		return
	for i in range(index, order_slips.size()):
		var temp: OrderSlip = order_slips[i]
		var tween = get_tree().create_tween()
		tween.tween_property(temp, "position", Vector2(temp.position.x - 300, temp.position.y), 1).set_trans(Tween.TRANS_BACK)
	
func error_message():
	print("Error: Popped wrong slip index")

func _on_slip_timer_timeout() -> void:
	var rand_order = OrderManager.daily_menu[current_day].pick_random()
	OrderManager.add_order(OrderManager.food_combos[rand_order])
	slip_timer.wait_time = randi_range(base_slip_timer - 3, base_slip_timer + 3)
	slip_timer.start()

func update_day(day: RoundManager.DAYS):
	current_day = day
	match_day()
	
func match_day():
	match current_day:
		RoundManager.DAYS.TUTORIAL_STAGE:
			base_slip_timer = 1000
			slip_timer.stop()
			OrderManager.add_order(OrderManager.food_combos[OrderManager.FOOD.LETTUCE_BURGER])
		RoundManager.DAYS.MONDAY:
			base_slip_timer = 15
		RoundManager.DAYS.TUESDAY:
			base_slip_timer = 14
		RoundManager.DAYS.WEDNESDAY:
			base_slip_timer = 13.5
		RoundManager.DAYS.THURSDAY:
			base_slip_timer = 13.5
		RoundManager.DAYS.FRIDAY:
			base_slip_timer = 12.5
