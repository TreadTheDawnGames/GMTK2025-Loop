extends Node2D
class_name PuzButton

var Pressed : bool = false

@onready var Sprite: Sprite2D = $Sprite2D
@onready var Area: Area2D = $Area2D
@onready var CollisionShape: CollisionShape2D = $Area2D/CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Area.mouse_entered.connect(func(): Pressed = true)
	Area.mouse_exited.connect(func(): Pressed = false)
	pass # Replace with function body.
