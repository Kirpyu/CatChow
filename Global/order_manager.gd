extends Node

signal added_order
signal completed_order
signal order_failed

var orders: Array[Array]

enum FOOD{
	BASIC_BURGER
}
var food_combos: Dictionary = {
	FOOD.BASIC_BURGER: preload("res://Resources/Orders/BasicBurger.tres")
}

func _ready() -> void:
	add_order(food_combos[FOOD.BASIC_BURGER])

func add_order(order: Order):
	orders.push_back(food_combos[FOOD.BASIC_BURGER].order)
	emit_signal("added_order", food_combos[FOOD.BASIC_BURGER])

func complete_order(order: Order):
	pass
