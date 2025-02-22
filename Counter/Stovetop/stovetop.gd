extends Counter

@export var burn_timer : Timer

enum STATES{
	IDLE,
	COOKED,
	BURNT,
	WORKING
}

var current_state: STATES = STATES.IDLE

func _ready() -> void:
	match_animation()

func entered():
	print("Hello")

func error_message():
	print("error: aint the right shit brother")

func do_task():
	match current_state:
		STATES.COOKED:
			current_state = STATES.IDLE
			burn_timer.stop()
			InventoryManager.add_storage(InventoryManager.ITEMS.COOKEDPATTY)
			match_animation()
			return
		STATES.BURNT:
			current_state = STATES.IDLE
			match_animation()
			return
		STATES.WORKING:
			return

	if InventoryManager.inventory.is_empty():
		error_message()
		return

	var item: Item = InventoryManager.inventory.back()
	if item.item_name == InventoryManager.ITEMS.RAWPATTY:
		InventoryManager.remove_inventory()
		work_timer.start()
		current_state = STATES.WORKING
		match_animation()
	else:
		error_message()
	
func match_animation():
	match current_state:
		STATES.IDLE:
			animated_sprite.play("default")
		STATES.COOKED:
			animated_sprite.play("cooking_cooked")
		STATES.BURNT:
			animated_sprite.play("cooking_burnt")
		STATES.WORKING:
			animated_sprite.play("cooking_raw")

func _on_work_timer_timeout() -> void:
	current_state = STATES.COOKED
	burn_timer.start()
	match_animation()

func _on_burn_timer_timeout() -> void:
	current_state = STATES.BURNT
	print("burnt")
	match_animation()
