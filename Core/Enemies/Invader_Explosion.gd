extends Node2D

@onready var sprite_2d: Sprite2D = %Sprite2D

func _on_invader_hit(invader: Invader) -> void:
	sprite_2d.set_position(invader.global_position)
	self.show()
	get_tree().create_tween().tween_property(self, "visible", false, 0.5)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Bus.invader_hit.connect(_on_invader_hit)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
