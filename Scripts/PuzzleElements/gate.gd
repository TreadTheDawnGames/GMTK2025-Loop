extends Node2D
class_name PuzGate
@export var Buttons : Array[PuzButton] = []

@onready var Sprite: Sprite2D = $Gate
@onready var CollisionShape: CollisionShape2D = $StaticBody2D/CollisionShape2D

func TryOpen() -> bool:
	for button : PuzButton in Buttons:
		print(button)
		if !button.Pressed:
			_Close()
			return false
	_Open()
	return true

func _Open():
	# Play open sound
	print("opening")
	Sprite.frame_coords.y = 1;
	CollisionShape.set_deferred("disabled", true)
	return

func _Close():
	print("close")
	# Play close sound
	Sprite.frame_coords.y = 0;
	CollisionShape.set_deferred("disabled", false)
	return

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Sprite  = get_node("Gate")
	CollisionShape = get_node("StaticBody2D/CollisionShape2D")
	for child in get_children():
		if child is PuzButton:
			Buttons.append(child)
	pass # Replace with function body.
