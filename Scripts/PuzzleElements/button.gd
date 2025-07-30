extends Node2D
class_name PuzButton

var Pressed : bool = false

@onready var Sprite: Sprite2D = $Sprite2D
@onready var Area: Area2D = $Area2D
@onready var CollisionShape: CollisionShape2D = $Area2D/CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Area.body_entered.connect(Press)
	Area.body_exited.connect(Unpress)
	pass # Replace with function body.

func ButtonInteraction(pressed : bool):
	Sprite.frame_coords.y = 1 if pressed else 0
	Pressed = pressed
	var parent = get_parent() as PuzGate
	parent.TryOpen()
	return

func Press(_node : Node2D):
	ButtonInteraction(true)
	return
func Unpress(_node : Node2D):
	ButtonInteraction(false)
	return
