extends Node2D

var player_velocity: int = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity: int = 0
	if Input.is_action_pressed("move_left"):
		velocity = -player_velocity
	if Input.is_action_pressed("move_right"):
		velocity = player_velocity
	self.position.x += velocity * delta
	self.position.x = min(max(12, self.position.x), 500)
	pass
