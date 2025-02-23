extends Counter

@export var dirty_plate_timer: Timer
func _ready() -> void:
	animated_sprite.play("default")
	OrderManager.connect("gained_coins", add_floating_text)

func do_task():
	for i in OrderManager.orders.size():
		if InventoryManager.inventory_names == OrderManager.orders[i]:
			OrderManager.complete_order(i)
			InventoryManager.clear_inventory()
			dirty_plate_timer.start()
			return

func add_floating_text(amt: int):
	var floating_text : Label= load("res://UI/FloatingText/floating_text.tscn").instantiate()
	floating_text.text = "+" + str(amt)
	floating_text.modulate = Color.LIME_GREEN
	self.add_child(floating_text)

func _on_dirty_plate_timer_timeout() -> void:
	InventoryManager.add_dirty_plate()
