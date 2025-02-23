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

var item_names: Dictionary = {
	ITEMS.CABBAGE: "CABBAGE",
	ITEMS.MUSHROOM: "MUSHROOM",
	ITEMS.TOMATO: "TOMATO",
	ITEMS.PICKLE: "PICKLE",
	ITEMS.CHEESE: "CHEESE",
	ITEMS.KETCHUP: "KETCHUP",
	ITEMS.MAYO: "MAYO",
	ITEMS.MUSTARD: "MUSTARD",
	ITEMS.RAW_PATTY: "RAW PATTY",
	ITEMS.COOKED_PATTY: "COOKED PATTY",
	ITEMS.CLEAN_DISH: "CLEAN DISH",
	ITEMS.DIRTY_DISH: "DIRTY DISH",
	ITEMS.BOTTOM_BUN: "BOTTOM BUN",
	ITEMS.UPPER_BUN: "TOP BUN",
	ITEMS.CHOPPED_CABBAGE: "CHOPPED CABBAGE",
	ITEMS.CHOPPED_MUSHROOM: "CHOPPED MUSHROOM",
	ITEMS.CHOPPED_TOMATO: "CHOPPED TOMATO",
	ITEMS.CHOPPED_PICKLE: "CHOPPED PICKLE", 
	ITEMS.CHOPPED_CHEESE: "CHOPPED CHEESE"
}

var chopped_version: Dictionary = {
	ITEMS.CABBAGE: ITEMS.CHOPPED_CABBAGE,
	ITEMS.CHEESE: ITEMS.CHOPPED_CHEESE,
	ITEMS.MUSHROOM: ITEMS.CHOPPED_MUSHROOM,
	ITEMS.PICKLE: ITEMS.CHOPPED_PICKLE,
	ITEMS.TOMATO: ITEMS.CHOPPED_TOMATO
}

var item_resources: Dictionary = {
	ITEMS.MUSTARD: preload("res://Resources/Items/Sauces/Mustard.tres"),
	ITEMS.RAW_PATTY: preload("res://Resources/Items/RawPatty.tres"),
	ITEMS.COOKED_PATTY: preload("res://Resources/Items/CookedPatty.tres"),
	ITEMS.KETCHUP: preload("res://Resources/Items/Sauces/Ketchup.tres"),
	ITEMS.MAYO: preload("res://Resources/Items/Sauces/Mayo.tres"),
	ITEMS.UPPER_BUN: preload("res://Resources/Items/UpperBun.tres"),
	ITEMS.BOTTOM_BUN: preload("res://Resources/Items/BottomBun.tres"),
	ITEMS.CABBAGE: preload("res://Resources/Items/Vegetables/WholeCabbage.tres"),
	ITEMS.MUSHROOM: preload("res://Resources/Items/Vegetables/WholeMushroom.tres"),
	ITEMS.TOMATO: preload("res://Resources/Items/Vegetables/WholeTomato.tres"),
	ITEMS.PICKLE: preload("res://Resources/Items/Vegetables/WholePickle.tres"),
	ITEMS.CHEESE: preload("res://Resources/Items/Vegetables/WholeCheese.tres"),
	ITEMS.CHOPPED_CABBAGE: preload("res://Resources/Items/Vegetables/ChoppedCabbage.tres"),
	ITEMS.CHOPPED_CHEESE: preload("res://Resources/Items/Vegetables/ChoppedCheese.tres"),
	ITEMS.CHOPPED_TOMATO: preload("res://Resources/Items/Vegetables/ChoppedTomato.tres"),
	ITEMS.CHOPPED_PICKLE: preload("res://Resources/Items/Vegetables/ChoppedPickle.tres"),
	ITEMS.CHOPPED_MUSHROOM: preload("res://Resources/Items/Vegetables/ChoppedMushroom.tres"),
	ITEMS.DIRTY_DISH: preload("res://Resources/Items/DirtyPlate.tres"),
	ITEMS.CLEAN_DISH: preload("res://Resources/Items/CleanPlate.tres"),
}

var daily_storage : Dictionary = {
	RoundManager.DAYS.TUTORIAL_STAGE: [
		
	],
	RoundManager.DAYS.MONDAY: [
		
	],
	RoundManager.DAYS.TUESDAY: [
		ITEMS.MUSTARD
	],
	RoundManager.DAYS.WEDNESDAY: [
		ITEMS.CHEESE, ITEMS.MUSTARD
	],
	RoundManager.DAYS.THURSDAY: [
		ITEMS.CHEESE, ITEMS.MUSTARD, ITEMS.TOMATO
	],
	RoundManager.DAYS.FRIDAY: [
		ITEMS.CHEESE, ITEMS.MUSTARD, ITEMS.TOMATO
	],
	RoundManager.DAYS.ENDING_STAGE: [
		
	],
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

signal added_button
func add_button(item_name: ITEMS) -> void:
	emit_signal("added_button", item_resources[item_name])

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

func refund_inventory():
	while inventory:
		var item = inventory.back()
		if not item.is_infinite:
			add_storage(item.item_name)
		remove_inventory()

func clear_inventory():
	while inventory:
		remove_inventory()

signal added_dirty_plate
func add_dirty_plate():
	emit_signal("added_dirty_plate")
