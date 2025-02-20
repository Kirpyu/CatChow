extends CharacterBody2D

class_name Player 

@export var speed : float
var current_counter : Counter
var counter_name : String

func _ready() -> void:
	InventoryManager.connect("updated_inventory", stub)

func _physics_process(delta: float) -> void:
	var walk = Input.get_axis("left", "right")
	position.x += walk * speed
	
	if Input.is_action_just_pressed("space"):
		if current_counter:
			print(current_counter.counter_name)
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

func stub():
	print("twerkin")
