extends Label

func _ready() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(self.position.x + randi_range(-20, 20), 
	self.position.y - randi_range(40, 60)), .5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "modulate:a", 0, 0.1)
	tween.connect("finished", queue_free)
