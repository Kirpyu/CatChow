extends Control

@export var coin_label: Label
@export var time_label: Label
@export var day_label: Label
func _ready() -> void:
	OrderManager.connect("gained_coins", update_coins)

var coins = 0
func update_coins(amt: int):
	coins += amt
	coin_label.text = "COINS: " + str(coins)
