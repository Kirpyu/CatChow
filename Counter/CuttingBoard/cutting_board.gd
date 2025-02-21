extends Counter

enum STATES{
	IDLE,
	WORKING
}

var current_state: STATES = STATES.IDLE
var current_vegetable: Vegetable

func do_task():
#	TO DO:
#	Similar to the stovetop, the player needs to submit an item to the chopping board
#	Wait maybe a second while completely still (moving cancels actions), and receive the
#	Item placed it.
#	The difficult part is that while the stove top guarantees a patty, this one requires an input
#	But it shouldnt be too hard if you reference the stovetop, since it only contains a few lines of code
	
#	FIRST STEP: Copy all the matches and if statements, these are standard checks
	
	var item: Item = InventoryManager.inventory.back()
	if item is Vegetable:
		current_vegetable = item
#		Continue
	else:
		print("Wrong sht dummy")
	pass
	
# Important Files: Stovetop.gd, Counter.gd, InventoryManager.gd, Item.gd, Vegetable.gd
# Assets: https://drive.google.com/drive/folders/19MIOBoE8y_InDS-DqDXXwmJtkfnvSMJC?usp=sharing

func _on_work_timer_timeout() -> void:
	current_state = STATES.IDLE
#	Chopped version of current_vegetable
	#InventoryManager.add_storage(InventoryManager.ITEMS.COOKED_PATTY)
	current_vegetable = null
