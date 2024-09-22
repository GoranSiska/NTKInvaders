@tool
class_name Invader extends Node2D

@export var sprite_frames: SpriteFrames:
	set(val):
		sprite_frames = val

@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D
@onready var area_2d: Area2D = %Area2D

func set_frame(frame: int) -> void:
	self.animated_sprite_2d.frame = frame

func _on_collision(area: Area2D) -> void:
	if area.get_collision_layer_value(2):
		Bus.invader_hit_side.emit()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.animated_sprite_2d.sprite_frames = self.sprite_frames
	#self.animated_sprite_2d.play()
	area_2d.area_entered.connect(_on_collision)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
