extends CharacterBody2D

#If AI touching, go in direction of AI walk.
#If in range of rail, clamp to rail.
@onready var Area: Area2D = $Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Area.get_overlapping_bodies().any(func(a): return a is NPC)):
		var npc : NPC = Area.get_overlapping_bodies().filter(func(a): return a is NPC)[0]
		
		var directionToMe = npc.global_position.direction_to(global_position)
		if(directionToMe.dot(npc.velocity) > 0):
			velocity = npc.velocity
		
	else:
		velocity = velocity.lerp(Vector2.ZERO, 0.25)
	move_and_slide()
	pass
