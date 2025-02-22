extends Counter

var current_state: STATES = STATES.IDLE

enum STATES{
	IDLE,
	WORKING
}

func _ready() -> void:
	match_animation()

func do_task():
	pass 
#	Remove pass when you finish
#	very similar to what you did yesterday
#	you can also look at stove top, instead of taking in patty, you have to take dirty dishes and return clean dishes
#	Dishes instead
#	Check if popped_item = InventoryManager.ITEMS.DIRTY_DISH, added to inventory item should be CLEAN_DISH
#	Make sure dirty dishes are set to finite and only has 3, if you leave it default at 0 it would bug

func match_animation() -> void:
	match current_state:
		STATES.IDLE:
			animated_sprite.play("default")
		STATES.WORKING:
			animated_sprite.play("working")

func _on_work_timer_timeout() -> void:
	pass
#	complete this also, with match animation this time, copy what you did with the cutting board
