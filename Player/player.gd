extends CharacterBody2D

class_name Player 

@export var speed : float
var current_counter : Counter
var counter_name : String
var stack_pos = Vector2(-57, -115)
@export var stack_area: Control
var stack_count = 0
var item_stack: Array[TextureRect] = []

func _ready() -> void:
	InventoryManager.connect("updated_inventory", update_inventory)
	InventoryManager.connect("removed_inventory", remove_inventory)

func _physics_process(delta: float) -> void:
	var walk = Input.get_axis("left", "right")
	position.x += walk * speed
	
	if Input.is_action_just_pressed("space"):
		if current_counter:
			current_counter.do_task()
		else:
			print("No Counter")

func update_counter(counter: Counter):
	current_counter = counter
	counter_name = current_counter.get_counter_name()
	print("Changed Counter To " + counter_name)

func remove_counter():
	current_counter = null
	counter_name = "None"
	print("Removed Counter")

func update_inventory(item: Item) -> void:
	stack(item)

func stack(item: Item) -> void:
	stack_count += 1
	var temp_texture : TextureRect = TextureRect.new()
	temp_texture.texture = item.texture
	temp_texture.set_global_position(Vector2(stack_pos.x, stack_pos.y - (15 * stack_count)))
	stack_area.add_child(temp_texture)
	item_stack.push_back(temp_texture)

func remove_inventory(item: Item) -> void:
	remove_item(item)
	
func remove_item(_item: Item) -> void:
	stack_count -= 1
	var temp_texture : TextureRect = item_stack.pop_back()
	temp_texture.queue_free()
