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
	RAWPATTY,
	COOKEDPATTY,
	CLEANDISH,
	DIRTYDISH,
	BOTTOMBUN,
	UPPERBUN,
	CHOPPEDCABBAGE,
	CHOPPEDMUSHROOM,
	CHOPPEDTOMATO,
	CHOPPEDPICKLE,
	CHOPPEDCHEESE
}

# Drive with images: https://drive.google.com/drive/u/0/folders/19MIOBoE8y_InDS-DqDXXwmJtkfnvSMJC
# TODO: fix item_names, add all of them
#var item_names: Dictionary = {
	#ITEMS.CABBAGE: "CABBAGE",
	#ITEMS.MUSHROOM: "MUSHROOM"
	#ITEMS.TOMATO: "TOMATO"
	#ITEMS.PICKLE: "PICKLE"
	#ITEMS.CHEESE: "CHEESE"
	#ITEMS.KETCHUP: "KETCHUP"
	#ITEMS.MAYO: "MAYO"
	#ITEMS.MUSTARD: "MUSTARD",
	#ITEMS.RAWPATTY:" RAWPATTY",
	#ITEMS.COOKEDPATTY: "COOKEDPATTY",
	#ITEMS.CLEANDISH: "CLEANDISH",
	#ITEMS.DIRTYDISH: "DIRTYDISH",
	#ITEMS.BOTTOMBUN: "BOTTOMBUN",
	#ITEMS.UPPERBUN: "UPPERBUN",
	#ITEMS.CHOPPEDCABBAGE: "CHOPPEDCABBAGE",
	#ITEMS.CHOPPEDMUSHROOM: "CHOPPEDMUSHROOM",
	#ITEMS.CHOPPEDTOMATO: "CHOPPEDTOMATO",
	#ITEMS.CHOPPEDPICKLE: "CHOPPEDPICKLE", 
	#ITEMS.CHOPPEDCHEESE: "CHOPPEDCHEESE"
#}

var chopped_version: Dictionary = {
	ITEMS.CABBAGE: ITEMS.CHOPPEDCABBAGE,
	ITEMS.CHEESE: ITEMS.CHOPPEDCHEESE,
	ITEMS.MUSHROOM: ITEMS.CHOPPEDMUSHROOM,
	ITEMS.PICKLE: ITEMS.CHOPPEDPICKLE,
	ITEMS.TOMATO: ITEMS.CHOPPEDTOMATO
}

#TODO: Add all resources
var item_resources: Dictionary = {
	ITEMS.COOKEDPATTY: preload("res://Resources/Items/CookedPatty.tres"),
	ITEMS.RAWPATTY: preload("res://Resources/Items/RawPatty.tres"),
	ITEMS.KETCHUP: preload("res://Resources/Items/Sauces/Ketchup.tres"),
	ITEMS.MUSTARD: preload("res://Resources/Items/Sauces/Mustard.tres"),
	ITEMS.MAYO: preload("res://Resources/Items/Sauces/Mayo.tres"),
	ITEMS.UPPERBUN: preload("res://Resources/Items/UpperBun.tres"),
	ITEMS.BOTTOMBUN: preload("res://Resources/Items/BottomBun.tres"),
	ITEMS.CHOPPEDCABBAGE: preload("res://Resources/Items/Vegetables/ChoppedCabbage.tres"),
	ITEMS.CHOPPEDCHEESE: preload("res://Resources/Items/Vegetables/ChoppedCheese.tres"),
	ITEMS.CHOPPEDMUSHROOM: preload("res://Resources/Items/Vegetables/ChoppedMushroom.tres"),
	ITEMS.CHOPPEDPICKLE: preload("res://Resources/Items/Vegetables/ChoppedPickle.tres"),
	ITEMS.CHOPPEDTOMATO: preload("res://Resources/Items/Vegetables/ChoppedTomato.tres"),
	ITEMS.CABBAGE: preload("res://Resources/Items/Vegetables/WholeCabbage.tres"),
	ITEMS.CHEESE: preload("res://Resources/Items/Vegetables/WholeCheese.tres"),
	ITEMS.MUSHROOM: preload("res://Resources/Items/Vegetables/WholeMushroom.tres"),
	ITEMS.PICKLE: preload("res://Resources/Items/Vegetables/WholePickle.tres"),
	ITEMS.TOMATO: preload("res://Resources/Items/Vegetables/WholeTomato.tres"),
	ITEMS.CLEANDISH: preload("res://Resources/Items/CleanDish.tres"),
	ITEMS.DIRTYDISH: preload("res://Resources/Items/DirtyDish.tres"),
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
