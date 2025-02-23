extends Counter

@export var burn_timer : Timer

enum STATES{
	IDLE,
	COOKED,
	BURNT,
	WORKING
}

var current_state : STATES = STATES.IDLE

func _ready() -> void:
	match_day()
	match_animation()
	base_work_timer = work_timer.wait_time
	base_burn_timer = burn_timer.wait_time

func entered():
	print("Hello")

func error_message():
	print("error: aint the right shit brother")

func do_task():
	match current_state:
		STATES.COOKED:
			current_state = STATES.IDLE
			burn_timer.stop()
			InventoryManager.add_storage(InventoryManager.ITEMS.COOKED_PATTY)
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
	if item.item_name == InventoryManager.ITEMS.RAW_PATTY:
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
			%Cooking.stop()
			%Burning.stop()
		STATES.COOKED:
			animated_sprite.play("cooking_cooked")
		STATES.BURNT:
			animated_sprite.play("cooking_burnt")
			%Cooking.stop()
			%Burning.play()
		STATES.WORKING:
			animated_sprite.play("cooking_raw")
			%Cooking.play()

@export var debuff_timer : Timer
var base_work_timer = 0
var base_burn_timer = 0
var debuffed = false
func debuff():
	while current_state != STATES.IDLE:
		await get_tree().process_frame
	animated_sprite.modulate = Color.INDIAN_RED
	debuffed = true
	work_timer.wait_time = base_work_timer * 0.5
	burn_timer.wait_time = base_burn_timer - 2.5
	%WorkBar.max_value = work_timer.wait_time
	%BurnBar.max_value = burn_timer.wait_time
	debuff_timer.start()
	%Debuffed.play()
	pass

func match_day():
	add_to_group("debuffable")

func _on_work_timer_timeout() -> void:
	current_state = STATES.COOKED
	burn_timer.start()
	match_animation()

func _on_burn_timer_timeout() -> void:
	current_state = STATES.BURNT
	match_animation()

func _on_debuff_timer_timeout() -> void:
	while current_state != STATES.IDLE:
		await get_tree().process_frame
	debuffed = false
	animated_sprite.modulate = Color.WHITE
	work_timer.wait_time = base_work_timer
	burn_timer.wait_time = base_burn_timer
	%WorkBar.max_value = work_timer.wait_time
	%BurnBar.max_value = burn_timer.wait_time
	%Debuffed.stop()
