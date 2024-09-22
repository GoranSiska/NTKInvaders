@tool
extends Node2D

enum Invader_Type {ALPHA, BETA, GAMMA}

const width: int = 11
const spacing_x: int = 32
const spacing_y: int = 28
var invaders: Array[Invader] = []

var invader_scene: PackedScene = load("res://Core/Enemies/Invader.tscn")
var alpha_sprite_sheet: SpriteFrames = load("res://Assets/Resources/Alpha_Sprite_Sheet.res")
var beta_sprite_sheet: SpriteFrames = load("res://Assets/Resources/Beta_Sprite_Sheet.res")
var gamma_sprite_sheet: SpriteFrames = load("res://Assets/Resources/Gamma_Sprite_Sheet.res")

var projectile_scene: PackedScene = load("res://Core/Enemies/Invader_Projectile.tscn")
var squiggle_sprite_sheet: SpriteFrames = load("res://Assets/Resources/Squiggle_Projectile_Sprite_Sheet.res")

func _init_wave() -> void:
	self.position.x = 40
	self.position.y = 100
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

func add_projectile(_projectile_position: Vector2) -> void:
	var projectile: Invader_Projectile = projectile_scene.instantiate()
	projectile.sprite_frames = self.squiggle_sprite_sheet
	self.owner.add_child(projectile)
	projectile.set_position(_projectile_position)

func add_invader(invader_type: Invader_Type) -> void:
	var invader: Invader = invader_scene.instantiate() as Invader
	match (invader_type):
		Invader_Type.ALPHA:
			invader.sprite_frames = alpha_sprite_sheet
			invader.invader_value = 10
		Invader_Type.BETA:
			invader.invader_value = 20
			invader.sprite_frames = beta_sprite_sheet
		Invader_Type.GAMMA:
			invader.sprite_frames = gamma_sprite_sheet
			invader.invader_value = 30
	var invaders_size: int = self.invaders.size()
	var x: int = invaders_size % self.width
	@warning_ignore("integer_division")
	var y: int = invaders_size / self.width
	var invader_position: Vector2 = Vector2(x*spacing_x, y*spacing_y)
	self.add_child(invader)
	self.invaders.append(invader)
	invader.set_position(invader_position)

func remove_invader(invader: Invader) -> void:
	self.invaders.erase(invader)
	invader.queue_free()
	if invaders.size() == 0:
		print("WIN")

func _on_invader_hit_side() -> void:
	if !self.is_move_down:
		self.invader_velocity = -self.invader_velocity
		self.is_move_down = true;

func _on_invader_hit(invader: Invader) -> void:
	self.remove_invader(invader)

func _ready() -> void:
	self._init_wave()
	Bus.invader_hit_side.connect(_on_invader_hit_side)
	Bus.invader_hit.connect(_on_invader_hit)
	pass # Replace with function body.


# Accumulater to lock-step invaders movement and frame change at half a second. 
var delta_accumulator: float = 0
var invader_velocity: int = 10
var invader_frame: int = 0
var is_move_down: bool = false;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if self.delta_accumulator < 0.5:
		self.delta_accumulator+=delta
		return
	self.delta_accumulator = 0
	
	self.invader_frame = ((self.invader_frame + 1) % 2)
	for i: Invader in self.invaders:
		i.set_frame(self.invader_frame)
	
	if Engine.is_editor_hint():
		return
		
	if is_move_down:
		self.position.y+=20
		self.is_move_down = false;
	else:
		self.position.x+=invader_velocity

	var squiggle_attack: bool = randf() > 0.5
	if squiggle_attack:
		var index: int = randi_range(0, self.invaders.size()-1)
		var attacking_invader: Invader = self.invaders[index]
		self.add_projectile(attacking_invader.global_position)


