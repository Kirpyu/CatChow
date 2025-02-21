extends Control

var order_slips: Array[OrderSlip] = []
var starting_pos = Vector2(64, 8)
var slip_amt = 0
@export var slips: Control

func _ready() -> void:
	OrderManager.connect("added_order", add_slip)
	

func add_slip(order: Order):
	var temp_slip: OrderSlip = load("res://UI/OrderSlip/order_slip.tscn").instantiate()
	temp_slip.order = order
	temp_slip.set_global_position(starting_pos)
	slips.add_child(temp_slip)
