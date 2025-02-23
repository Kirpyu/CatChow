extends Sprite2D

var player: Player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	
func _process(delta: float) -> void:
	self.global_position = Vector2(player.global_position.x, player.global_position.y + 10)
