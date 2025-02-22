extends Counter

enum STATES{
	IDLE,
	WORKING
}

var current_state: STATES = STATES.IDLE

func _ready() -> void:
	match_animation()

func do_task():
	if current_state == STATES.WORKING:
		print("Working")
		return
		
	if InventoryManager.inventory.is_empty():
		error_message()
		return	
		
	var item: Item = InventoryManager.inventory.back()
	if item.item_name == InventoryManager.ITEMS.DIRTY_DISH:
		InventoryManager.remove_inventory()
		work_timer.start()
		current_state = STATES.WORKING
		match_animation()
	else:
		error_message()

func _on_work_timer_timeout() -> void:
	current_state = STATES.IDLE
	InventoryManager.add_storage(InventoryManager.ITEMS.CLEAN_DISH)
	match_animation()
			
func match_animation() -> void:
	match current_state:
		STATES.IDLE:
			animated_sprite.play("default")
		STATES.WORKING:
			animated_sprite.play("working")
