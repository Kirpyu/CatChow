extends Counter

var stack_count = 0
var stack_pos = Vector2(-82,-32)
var item_stack: Array[TextureRect] = []
@onready var stack_area = $StackArea

func _ready() -> void:
	InventoryManager.connect("added_dirty_plate", add_dirty_plate)

func do_task():
	if item_stack:
		var temp_dish = item_stack.pop_back()
		InventoryManager.add_storage(InventoryManager.ITEMS.DIRTY_DISH)
		temp_dish.queue_free()
		stack_count -= 1

func add_dirty_plate():
	stack(InventoryManager.item_resources[InventoryManager.ITEMS.DIRTY_DISH])

func stack(item: Item) -> void:
	stack_count += 1
	var temp_texture : TextureRect = TextureRect.new()
	temp_texture.texture = item.texture
	temp_texture.set_global_position(Vector2(stack_pos.x, stack_pos.y - (22 * stack_count)))
	temp_texture.scale = Vector2(1.5, 1.5)
	stack_area.add_child(temp_texture)
	item_stack.push_back(temp_texture)
