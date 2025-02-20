extends Node

signal updated_inventory

enum ITEMS{
	CABBAGE,
	MUSHROOM,
	TOMATO,
	PICKLE,
	CHEESE,
	KETCHUP,
	MAYO,
	MUSTARD,
	PATTY,
	CLEANDISH,
	DIRTYDISH
}

var inventory: Array[Item] = []

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("tab"):
		test()
		
func test():
	emit_signal("updated_inventory")

func add_inventory(item: Item) -> void:
	inventory.push_back(item)
	emit_signal("updated_inventory")

func get_inventory() -> Item:
	return Item.new()
