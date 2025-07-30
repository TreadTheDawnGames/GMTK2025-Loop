extends CharacterBody2D

#If AI touching, go in direction of AI walk.
#If in range of rail, clamp to rail.
@onready var Area: Area2D = $Area2D
enum FacingDir {North, South, East, West}
var Facing : FacingDir

@onready var Sprite: Sprite2D = $Sprite

var isOnRail : bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(velocity.x > 0):
		Facing = FacingDir.West
	if(velocity.x < 0):
		Facing = FacingDir.East
	if(velocity.y > 0):
		Facing = FacingDir.South
	if(velocity.y < 0):
		Facing = FacingDir.North
	
	if(Area.get_overlapping_bodies().any(func(a): return a is NPC)):
		var npc : NPC = Area.get_overlapping_bodies().filter(func(a): return a is NPC)[0]
		var directionToNPC = global_position.direction_to(npc.global_position)
		
		if(directionToNPC.dot(-((npc.WalkDir).normalized() - to_local(global_position).normalized())) > 0):
			velocity = npc.WalkDir * npc.speed
	else:
		velocity = velocity.lerp(Vector2.ZERO, 0.25)
	if(velocity.length() > 0.05):
		Sprite.frame_coords = Vector2(1, 1) + velocity.normalized().round()
	move_and_slide()
	#queue_redraw()
	pass

func _ready() -> void:
	isOnRail = Area.get_overlapping_areas().any(func(a): a.owner is PuzRail)
	print("isOnRail:" + str(isOnRail))
	return
