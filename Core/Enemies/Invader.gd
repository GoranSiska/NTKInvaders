@tool
extends Node2D

@export var sprite_frames: SpriteFrames:
	set(val):
		sprite_frames = val

@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.animated_sprite_2d.sprite_frames = self.sprite_frames
	self.animated_sprite_2d.play()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
