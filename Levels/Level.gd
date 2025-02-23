extends Node2D

@export var day : RoundManager.DAYS

func _ready() -> void:
	InventoryManager.reset_resources()
	OrderManager.reset_order()
	RoundManager.update_day(day)
	add_storage()

func add_storage():
	for item in InventoryManager.daily_storage[RoundManager.current_day]:
		InventoryManager.add_button(item)
