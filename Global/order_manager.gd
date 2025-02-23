extends Node

signal added_order
signal completed_order
signal order_failed

var orders: Array[Array]

enum FOOD{
	BASIC_BURGER,
	LETTUCE_BURGER,
	CHEESE_BURGER,
	CHEESE_LETTUCE_BURGER,
	TOMATO_BURGER,
	KETCHUP_BURGER,
	MUSTARD_BURGER,
	LETTUCE_MUSTARD_BURGER,
	CHEESE_DOUBLE_PATTY,
	TOMATO_LETTUCE_MUSTARD_BURGER,
	LETTUCE_TOMATO_DOUBLE_PATTY_BURGER
}
var food_combos: Dictionary = {
	FOOD.BASIC_BURGER: preload("res://Resources/Orders/BasicBurger.tres"),
	FOOD.LETTUCE_BURGER: preload("res://Resources/Orders/LettuceBurger.tres"),
	FOOD.CHEESE_BURGER: preload("res://Resources/Orders/CheeseBurger.tres"),
	FOOD.CHEESE_LETTUCE_BURGER: preload("res://Resources/Orders/CheeseLettuceBurger.tres"),
	FOOD.TOMATO_BURGER: preload("res://Resources/Orders/TomatoBurger.tres"),
	FOOD.KETCHUP_BURGER: preload("res://Resources/Orders/KetchupBurger.tres"),
	FOOD.MUSTARD_BURGER: preload("res://Resources/Orders/MustardBurger.tres"),
	FOOD.LETTUCE_MUSTARD_BURGER: preload("res://Resources/Orders/LettuceMustardBurger.tres"),
	FOOD.CHEESE_DOUBLE_PATTY: preload("res://Resources/Orders/CheeseDoublePattyBurger.tres"),
	FOOD.TOMATO_LETTUCE_MUSTARD_BURGER: preload("res://Resources/Orders/TomatoLettuceMustardHamburger.tres"),
	FOOD.LETTUCE_TOMATO_DOUBLE_PATTY_BURGER: preload("res://Resources/Orders/LettuceTomatoDoublePatty.tres")
}

var daily_menu: Dictionary = {
	RoundManager.DAYS.MONDAY: [
		FOOD.BASIC_BURGER, FOOD.LETTUCE_BURGER, FOOD.KETCHUP_BURGER
	],
	RoundManager.DAYS.TUESDAY: [
		FOOD.BASIC_BURGER, FOOD.LETTUCE_MUSTARD_BURGER, FOOD.MUSTARD_BURGER, FOOD.KETCHUP_BURGER
	],
	RoundManager.DAYS.WEDNESDAY: [
		FOOD.BASIC_BURGER, FOOD.LETTUCE_BURGER, FOOD.MUSTARD_BURGER, 
		FOOD.CHEESE_LETTUCE_BURGER, FOOD.KETCHUP_BURGER,
		FOOD.CHEESE_BURGER, FOOD.LETTUCE_MUSTARD_BURGER
	],
	RoundManager.DAYS.THURSDAY: [
		FOOD.CHEESE_LETTUCE_BURGER, FOOD.KETCHUP_BURGER,
		FOOD.CHEESE_BURGER, FOOD.LETTUCE_MUSTARD_BURGER, FOOD.CHEESE_DOUBLE_PATTY, 
		FOOD.TOMATO_LETTUCE_MUSTARD_BURGER
	],
	RoundManager.DAYS.FRIDAY: [
		 FOOD.LETTUCE_TOMATO_DOUBLE_PATTY_BURGER, FOOD.TOMATO_BURGER, 
		FOOD.CHEESE_BURGER, FOOD.CHEESE_DOUBLE_PATTY, FOOD.KETCHUP_BURGER
	],
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
