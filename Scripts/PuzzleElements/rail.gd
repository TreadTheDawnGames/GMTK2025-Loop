extends Node2D
class_name PuzRail

@export var RailDirection : PuzMinecart.RailDir
@onready var Area: Area2D = $Area2D
@onready var Sprite: Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match RailDirection:
		PuzMinecart.RailDir.NorthSouth:
			SetFrameCoords(4, 1)
			pass
		PuzMinecart.RailDir.EastWest:
			SetFrameCoords(5, 1)
			pass
		PuzMinecart.RailDir.UpDiagNEWS:
			SetFrameCoords(4, 2)
			pass
		PuzMinecart.RailDir.DownDiagNEWS:
			SetFrameCoords(4, 0)
			pass
		PuzMinecart.RailDir.UpDiagNWES:
			SetFrameCoords(5,2)
			pass
		PuzMinecart.RailDir.DownDiagNWES:
			SetFrameCoords(5, 0)
			pass	
	pass # Replace with function body.

func SetFrameCoords(x, y):
	Sprite.frame_coords = Vector2(x, y)
	return
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
