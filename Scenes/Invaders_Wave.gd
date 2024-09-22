@tool
extends Node2D


enum Invader_Type {ALPHA, BETA, GAMMA}

const width: int = 11
const spacing_x: int = 32
const spacing_y: int = 28
var invaders: Array[Invader] = []

var invaderScene: PackedScene = load("res://Core/Enemies/Invader.tscn")
var alpha_sprite_sheet: SpriteFrames = load("res://Assets/Resources/Alpha_Sprite_Sheet.res")
var beta_sprite_sheet: SpriteFrames = load("res://Assets/Resources/Beta_Sprite_Sheet.res")
var gamma_sprite_sheet: SpriteFrames = load("res://Assets/Resources/Gamma_Sprite_Sheet.res")

func _init_wave() -> void:
	for i in self.invaders:
		i.queue_free()
	self.invaders.resize(0)
	for i in range(width):
		add_invader(Invader_Type.GAMMA)
	for i in range(width):
		add_invader(Invader_Type.BETA)
		add_invader(Invader_Type.BETA)
	for i in range(width):
		add_invader(Invader_Type.ALPHA)
		add_invader(Invader_Type.ALPHA)

func add_invader(invader_type: Invader_Type) -> void:
	var invader: Invader = invaderScene.instantiate() as Invader
	match (invader_type):
		Invader_Type.ALPHA:
			invader.sprite_frames = alpha_sprite_sheet
		Invader_Type.BETA:
			invader.sprite_frames = beta_sprite_sheet
		Invader_Type.GAMMA:
			invader.sprite_frames = gamma_sprite_sheet
	var invaders_size: int = self.invaders.size()
	var x: int = invaders_size % self.width
	var y: int = invaders_size / self.width
	var invader_position: Vector2 = Vector2(x*spacing_x, y*spacing_y)
	self.add_child(invader)
	self.invaders.append(invader)
	invader.set_position(invader_position)
# Called when the node enters the scene tree for the first time.


func _ready() -> void:
	self._init_wave()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
