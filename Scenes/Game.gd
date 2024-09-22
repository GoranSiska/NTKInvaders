extends Node2D

@onready var score_label: RichTextLabel = %Score_Label
@onready var menu_animation: AnimationPlayer = %MenuAnimation

var score: int = 0

func _on_invader_hit(invader: Invader) -> void:
	score += invader.invader_value
	score_label.text = "SCORE:\n%06d" % score
	
func _on_player_hit(player: Player) -> void:
	print("Game over")
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Bus.invader_hit.connect(_on_invader_hit)
	Bus.player_hit.connect(_on_player_hit)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
