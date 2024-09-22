class_name Player extends Node2D

var player_velocity: int = 200
var player_projectile_scene: PackedScene = load("res://Core/Player/Player_Projectile.tscn")
var player_can_fire: bool = true

func _on_player_projectile_hit() -> void:
	self.player_can_fire = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Bus.player_projectile_hit.connect(_on_player_projectile_hit)
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
	if Input.is_action_just_pressed("fire") && self.player_can_fire:
		self.player_can_fire = false
		var player_projectile: Node2D = self.player_projectile_scene.instantiate()
		self.owner.add_child(player_projectile)
		player_projectile.set_position(Vector2(self.position))
	pass
