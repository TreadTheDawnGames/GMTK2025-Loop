extends Node2D
class_name PuzButton

var Pressed : bool = false

@onready var Sprite: Sprite2D = $Sprite2D
@onready var Area: Area2D = $Area2D
@onready var CollisionShape: CollisionShape2D = $Area2D/CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Area.mouse_entered.connect(ButtonInteraction.bind(true))
	Area.mouse_exited.connect(ButtonInteraction.bind(false))
	pass # Replace with function body.

func ButtonInteraction(pressed : bool):
	Sprite.frame_coords.y = 1 if pressed else 0
	Pressed = pressed
	return
