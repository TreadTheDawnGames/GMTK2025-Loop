extends PuzGate
class_name PuzDoor

@export var Keys : Array = []
@onready var Area: Area2D = $Area2D
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D

func _ready():
	super._ready()
	Area.body_entered.connect(TryOpenDoor)
	return
	
	
func TryOpenDoor(node : Node2D) -> bool:
	if(node is not NPC):
		return false
	else:
		var npc = node as NPC
		for key in Keys:
			if not npc.CollectedKeys.has(key):
				_Close()
				return false
		_Open()
	return true
