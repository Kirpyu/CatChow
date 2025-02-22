extends Node

signal added_order
signal completed_order
signal order_failed

var orders: Array[Array]

enum FOOD{
	BASIC_BURGER,
	LETTUCE_BURGER
}
var food_combos: Dictionary = {
	FOOD.BASIC_BURGER: preload("res://Resources/Orders/BasicBurger.tres"),
	FOOD.LETTUCE_BURGER: preload("res://Resources/Orders/LettuceBurger.tres")
}

func add_order(order: Order):
	orders.push_back(order.order)
	emit_signal("added_order", order)

func complete_order(index: int):
	var temp = orders.pop_at(index)
	emit_signal("completed_order", temp, index)

signal gained_coins
var coins: int = 0
func gain_coins(amt: int):
	coins += amt
	emit_signal("gained_coins", amt)
