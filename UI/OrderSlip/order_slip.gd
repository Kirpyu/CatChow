extends Control
class_name OrderSlip

@export var order: Order

var stack_count = 0
var stack_pos = Vector2(75,130)
@onready var stack_area = $StackArea

func _ready() -> void:
	for item: InventoryManager.ITEMS in order.order:
		stack(item)
		
func stack(item: InventoryManager.ITEMS) -> void:
	stack_count += 1
	var temp_texture : TextureRect = TextureRect.new()
	temp_texture.texture = InventoryManager.item_resources[item].texture
	temp_texture.set_position(Vector2(stack_pos.x, stack_pos.y - (20 * stack_count)))
	temp_texture.scale = Vector2(1.5, 1.5)
	stack_area.add_child(temp_texture)
