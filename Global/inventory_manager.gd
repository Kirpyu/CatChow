extends Node

signal updated_inventory
signal removed_inventory
signal added_storage
signal removed_storage

enum ITEMS{
	CABBAGE,
	MUSHROOM,
	TOMATO,
	PICKLE,
	CHEESE,
	KETCHUP,
	MAYO,
	MUSTARD,
	RAW_PATTY,
	COOKED_PATTY,
	CLEAN_DISH,
	DIRTY_DISH,
	BOTTOM_BUN,
	UPPER_BUN,
	CHOPPED_CABBAGE,
	CHOPPED_MUSHROOM,
	CHOPPED_TOMATO,
	CHOPPED_PICKLE,
	CHOPPED_CHEESE
}

var item_resources: Dictionary = {
	ITEMS.COOKED_PATTY: preload("res://Resources/Items/CookedPatty.tres"),
	ITEMS.KETCHUP: preload("res://Resources/Items/Sauces/Ketchup.tres"),
	ITEMS.UPPER_BUN: preload("res://Resources/Items/UpperBun.tres"),
	ITEMS.BOTTOM_BUN: preload("res://Resources/Items/BottomBun.tres")
}
var inventory: Array[Item] = []
var inventory_names: Array[ITEMS]
var storage: Dictionary = {}

# Ensure item is not infinite
func add_storage(item_name: ITEMS) -> void:
	var item = item_resources[item_name]
	item.amount += 1
	storage[item_name] = item.amount
	emit_signal("added_storage", item)
	

func remove_storage(item: Item) -> void:
	if item.item_name not in storage and item.amount >= 1:
		item.amount -= 1
		add_storage(item.item_name)
	
	if not item.is_infinite:
		storage[item.item_name] -= 1
	emit_signal("removed_storage", item)

func add_inventory(item: Item) -> void:
	inventory.push_back(item)
	inventory_names.push_back(item.item_name)
	emit_signal("updated_inventory", item)

func get_inventory() -> Item:
	return Item.new()

func remove_inventory():
	var item : Item = inventory.pop_back()
	inventory_names.pop_back()
	emit_signal("removed_inventory", item)

func clear_inventory():
	inventory = []
	inventory_names = []
