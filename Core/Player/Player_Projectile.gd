extends Node2D

@onready var area_2d: Area2D = %Area2D

var projectile_velocity: int = 400

func _on_collision(area: Area2D) -> void:
	Bus.player_projectile_hit.emit()
	if area.get_collision_layer_value(3):
		if area.get_parent() is Invader:
			Bus.invader_hit.emit(area.get_parent() as Invader)
	self.queue_free()
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_2d.area_entered.connect(_on_collision)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.position.y -= projectile_velocity * delta
	pass
