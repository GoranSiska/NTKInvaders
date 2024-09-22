class_name Invader_Projectile extends Node2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var area_2d: Area2D = $Area2D

@export var sprite_frames: SpriteFrames:
	set(val):
		sprite_frames = val

var projectile_velocity: int = 200

func _on_collision(area: Area2D) -> void:
	if area.get_collision_layer_value(5):
		if area.get_parent() is Player:
			Bus.player_hit.emit(area.get_parent() as Player)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.animated_sprite_2d.sprite_frames = self.sprite_frames
	self.animated_sprite_2d.play()
	self.area_2d.area_entered.connect(_on_collision)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.position.y += projectile_velocity * delta
	pass
