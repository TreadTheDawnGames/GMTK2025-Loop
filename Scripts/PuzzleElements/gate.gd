extends Node2D
class_name PuzGate
@export var Buttons : Array[PuzButton] = []

@onready var Sprite: Sprite2D = $Gate
@onready var CollisionShape: CollisionShape2D = $StaticBody2D/CollisionShape2D

func TryOpen() -> bool:
	for button : PuzButton in Buttons:
		if !button.pressed:
			_Close()
			return false
	_Open()
	return true

func _Open():
	# Play open sound
	Sprite.frame_coords.y = 1;
	CollisionShape.disabled = true
	return

func _Close():
	# Play close sound
	Sprite.frame_coords.y = 0;
	CollisionShape.disabled = false
	return

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Sprite  = get_node("Gate")
	CollisionShape = get_node("StaticBody2D/CollisionShape2D")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
