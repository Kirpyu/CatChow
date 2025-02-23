extends Control

@export var lerp_speed = 0.25

var is_popped : bool = false
const _right_anchor = Vector2(1.2, 1)
const _left_anchor = Vector2(.75, 1)
var target_anchor = _right_anchor

var buttons: Array[ItemButton] = []

func _ready() -> void:
	InventoryManager.connect("added_storage", handle_added_storage)
	InventoryManager.connect("added_button", handle_added_button)
	for button: ItemButton in %Buttons.get_children():
		buttons.append(button)
		button.item_button.connect("pressed", on_item_button_pressed.bind(button))

func _process(delta: float) -> void:
	anchor_right = lerp(anchor_right, target_anchor.y, lerp_speed)
	anchor_left = lerp(anchor_left, target_anchor.x, lerp_speed)
	
	if Input.is_action_just_pressed("tab"):
		handle_button_press()

func handle_button_press():
	if is_popped:
		target_anchor = _right_anchor
	else:
		target_anchor = _left_anchor
	is_popped = !is_popped
	
func _on_texture_button_pressed() -> void:
	handle_button_press()

func on_item_button_pressed(button: ItemButton):
	InventoryManager.add_inventory(button.item)
	%ButtonClicked.play()
	if not button.item.is_infinite:
		button.item.amount -= 1
		InventoryManager.remove_storage(button.item)
		if button.item.amount == 0:
			buttons.erase(button)
			button.queue_free()

func handle_added_storage(item: Item):
	if item.amount == 1:
		var button : ItemButton = load("res://UI/item_button.tscn").instantiate()
		button.item = item
		buttons.append(button)
		%Buttons.add_child(button)
		button.item_button.connect("pressed", on_item_button_pressed.bind(button))

func handle_added_button(item: Item):
	var button : ItemButton = load("res://UI/item_button.tscn").instantiate()
	button.item = item
	buttons.append(button)
	%Buttons.add_child(button)
	button.item_button.connect("pressed", on_item_button_pressed.bind(button))


func _on_button_pressed() -> void:
	InventoryManager.refund_inventory()
	%ButtonRefund.play()
