extends Counter

enum STATES{
	IDLE,
	WORKING
}

var current_state: STATES = STATES.IDLE
var player: Player
var debuffed: bool = false
@export var debuff_timer : Timer

func _ready() -> void:
	match_animation()
	player = get_tree().get_first_node_in_group("player")
	RoundManager.connect("updated_day", match_day)

var task_cancelled = true
func _process(delta: float) -> void:
	if debuffed == true and player.velocity != Vector2(0,0) and not task_cancelled:
		cancel_task()

func do_task():
	if current_state == STATES.WORKING:
		print("Working")
		return
		
	if InventoryManager.inventory.is_empty():
		error_message()
		return	
		
	var item: Item = InventoryManager.inventory.back()
	if item.item_name == InventoryManager.ITEMS.DIRTY_DISH:
		task_cancelled = false
		InventoryManager.remove_inventory()
		work_timer.start()
		current_state = STATES.WORKING
		match_animation()
	else:
		error_message()

func cancel_task():
	task_cancelled = true
	InventoryManager.add_storage(InventoryManager.ITEMS.DIRTY_DISH)
	work_timer.stop()
	current_state = STATES.IDLE
	match_animation()

func _on_work_timer_timeout() -> void:
	task_cancelled = true
	current_state = STATES.IDLE
	InventoryManager.add_storage(InventoryManager.ITEMS.CLEAN_DISH)
	match_animation()
			
func match_animation() -> void:
	match current_state:
		STATES.IDLE:
			animated_sprite.play("default")
			%WaterRunning.stop()
			%PickUpPlate.play()
		STATES.WORKING:
			animated_sprite.play("working")
			%WaterRunning.play()
			
func debuff():
	while current_state != STATES.IDLE:
		await get_tree().process_frame
	debuffed = true
	animated_sprite.modulate = Color.INDIAN_RED
	%Break.play()
	debuff_timer.start()

func _on_debuff_timer_timeout() -> void:
	debuffed = false
	animated_sprite.modulate = Color.WHITE
	%Break.stop()

func match_day(day):
	if day != RoundManager.DAYS.MONDAY:
		add_to_group("debuffable")
