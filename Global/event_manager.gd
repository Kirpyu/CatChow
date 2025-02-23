extends Node2D

@export var event_timer : Timer
var base_time : float = 0
var debuffable : Array = []
func _ready() -> void:
	RoundManager.connect("updated_day", match_day)

func _on_event_timer_timeout() -> void:
	if debuffable.size() <= 0:
		return
	
	var node = null
	var temp_removed = []
	
	print(debuffable)
	while debuffable.size() > 0:
		var random_int = randi_range(0, debuffable.size() - 1)
		print(random_int)
		node = debuffable[random_int]
		
		if node.has_method("debuff") and not node.debuffed:
			break
			
		temp_removed.append(debuffable.pop_at(random_int))
		
	
	if node.has_method("debuff") and not node.debuffed:
		node.debuff()
		event_timer.wait_time = randf_range(base_time - 3, base_time + 3)
	
	debuffable.append_array(temp_removed)

func match_day(day) -> void:
	for node in get_tree().get_nodes_in_group("debuffable"):
		debuffable.append(node)
		
	match day:
		RoundManager.DAYS.TUTORIAL_STAGE:
			base_time = 100000
		RoundManager.DAYS.MONDAY:
			base_time = 20
		RoundManager.DAYS.TUESDAY:
			base_time = 18.5
		RoundManager.DAYS.WEDNESDAY:
			base_time = 16
		RoundManager.DAYS.THURSDAY:
			base_time = 16
		RoundManager.DAYS.FRIDAY:
			base_time = 13.5
	event_timer.wait_time = base_time
	event_timer.start()
