extends Counter

enum STATES{
	IDLE,
	WORKING
}

var current_state: STATES = STATES.IDLE
var current_vegetable: Vegetable

func _ready() -> void:
	animated_sprite.play("default")

func do_task():
	if current_state == STATES.WORKING:
		print("Working")
		return
	
	if InventoryManager.inventory.is_empty():
		error_message()
		return	
		
	var item: Item = InventoryManager.inventory.back()
	if item is Vegetable:
		current_vegetable = item
		InventoryManager.remove_inventory()
		work_timer.start()
		current_state = STATES.WORKING
		match_animation()
	else:
		print("Wrong sht dummy")

func _on_work_timer_timeout() -> void:
	current_state = STATES.IDLE
	InventoryManager.add_storage(InventoryManager.chopped_version[current_vegetable.item_name])
	current_vegetable = null
	match_animation()

func match_animation() -> void:
	match current_state:
		STATES.IDLE:
			animated_sprite.play("default")
		STATES.WORKING:
			animated_sprite.play("working")
