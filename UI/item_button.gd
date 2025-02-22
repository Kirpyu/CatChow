extends HBoxContainer
class_name ItemButton

@export var item: Item
@export var item_button : TextureButton
@export var counter : Label
# Make Texture ingredients texture
# Clicking this creates the ingredient and stacks it on cats head, adds it to a stack
# Max stack of 7 

func _ready() -> void:
	item_button.texture_normal = item.texture
	handle_updated_storage(item)
	InventoryManager.connect("added_storage", handle_updated_storage)
	InventoryManager.connect("removed_storage", handle_updated_storage)

func handle_updated_storage(given_item: Item):
	if item.amount > 0 and given_item.item_name == item.item_name:
		var item_name = InventoryManager.item_names[item.item_name]
		counter.text = item_name + " x" + str(item.amount)
