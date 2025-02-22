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

# Drive with images: https://drive.google.com/drive/u/0/folders/19MIOBoE8y_InDS-DqDXXwmJtkfnvSMJC
# TODO: fix item_names, add all of them
#var item_names: Dictionary = {
	#ITEMS.CABBAGE: "CABBAGE",
	#ITEMS.MUSHROOM:
	#ITEMS.TOMATO:
	#ITEMS.PICKLE:
	#ITEMS.CHEESE:
	#ITEMS.KETCHUP:
	#ITEMS.MAYO,
	#ITEMS.MUSTARD,
	#ITEMS.RAW_PATTY,
	#ITEMS.COOKED_PATTY,
	#ITEMS.CLEAN_DISH,
	#ITEMS.DIRTY_DISH,
	#ITEMS.BOTTOM_BUN,
	#ITEMS.UPPER_BUN,
	#ITEMS.CHOPPED_CABBAGE,
	#ITEMS.CHOPPED_MUSHROOM,
	#ITEMS.CHOPPED_TOMATO,
	#ITEMS.CHOPPED_PICKLE,
	#ITEMS.CHOPPED_CHEESE
#}

var chopped_version: Dictionary = {
	ITEMS.CABBAGE: ITEMS.CHOPPED_CABBAGE,
	ITEMS.CHEESE: ITEMS.CHOPPED_CHEESE,
	ITEMS.MUSHROOM: ITEMS.CHOPPED_MUSHROOM,
	ITEMS.PICKLE: ITEMS.CHOPPED_PICKLE,
	ITEMS.TOMATO: ITEMS.CHOPPED_TOMATO
}

#TODO: Add all resources
var item_resources: Dictionary = {
	ITEMS.COOKED_PATTY: preload("res://Resources/Items/CookedPatty.tres"),
	ITEMS.KETCHUP: preload("res://Resources/Items/Sauces/Ketchup.tres"),
	ITEMS.UPPER_BUN: preload("res://Resources/Items/UpperBun.tres"),
	ITEMS.BOTTOM_BUN: preload("res://Resources/Items/BottomBun.tres"),
	ITEMS.CHOPPED_CABBAGE: preload("res://Resources/Items/Vegetables/ChoppedCabbage.tres")
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

func refund_inventory():
	while inventory:
		var item = inventory.back()
		if not item.is_infinite:
			add_storage(item.item_name)
		remove_inventory()

func clear_inventory():
	while inventory:
		remove_inventory()
