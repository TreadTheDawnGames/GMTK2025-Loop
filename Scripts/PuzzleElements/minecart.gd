extends CharacterBody2D
class_name PuzMinecart
#If AI touching, go in direction of AI walk.
#If in range of rail, clamp to rail.
@onready var Area: Area2D = $Area2D
enum RailDir {NorthSouth, EastWest, UpDiagNEWS, DownDiagNEWS, UpDiagNWES, DownDiagNWES}
var Facing : RailDir
var Turning : bool = false
@onready var Sprite: Sprite2D = $Sprite

var isOnRail : bool = false:
	get:
		return isOnRail
	set(value):
		if(value == true):
			Sprite.position.y = -4
		else:
			Sprite.position.y = -2
		isOnRail = value

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#Check for if AI is pushing and if it is go in the direction the AI is going.
	if(Area.get_overlapping_bodies().any(func(a): return a is NPC)):
		var npc : NPC = Area.get_overlapping_bodies().filter(func(a): return a is NPC)[0]
		var directionToNPC = global_position.direction_to(npc.global_position)
		
		if(directionToNPC.dot(-((npc.WalkDir).normalized() - to_local(global_position).normalized())) > 0.1):
			velocity = npc.WalkDir * npc.speed
	# If not on a rail be slow
	elif not isOnRail:
		velocity = velocity.lerp(Vector2.ZERO, 0.25)
	
	#Set frame for the direction the cart is going
	if(velocity.length() > 0.05):
		Sprite.frame_coords = Vector2(1, 1) + velocity.normalized().round()
	
	#Set velocity based on facing (don't move up and down if on a horizontal rail)
	if(isOnRail):
		match Facing:
			RailDir.NorthSouth:
				print("facing northsouth")
				velocity.x = 0
				pass
			RailDir.EastWest:
				print("facing eastwest")
				velocity.y = 0
				pass
			RailDir.UpDiagNEWS:
				pass
			RailDir.DownDiagNEWS:
				pass
			RailDir.UpDiagNWES:
				pass
			RailDir.DownDiagNWES:
				pass
		velocity = velocity.lerp(Vector2.ZERO, 0.01)
		pass
	
	#check to make sure you're still on a rail
	if(not Area.get_overlapping_areas().any(func(a): return a.owner is PuzRail)):
		isOnRail = false
	else:
		#if there IS a rail, find which rail you're closest to
		var closestRail : PuzRail
		var distToRail : float = INF
		for area in Area.get_overlapping_areas().filter(func(a): return a.owner is PuzRail):
			var rail = area.owner as PuzRail
			if(global_position.distance_to(rail.global_position) < distToRail):
				closestRail = rail
				distToRail = global_position.distance_to(rail.global_position)
		
		#if the closest rail is a corner, do special corner stuff
		if(closestRail.RailDirection == RailDir.DownDiagNWES):
			if(distToRail < 0.5):
				print("really close")
				Sprite.frame_coords = Vector2(0,2)
				velocity = Vector2(0, 50)
				Facing = RailDir.NorthSouth
			pass
	move_and_slide()
	queue_redraw()
	pass

func _ready() -> void:
	isOnRail = Area.get_overlapping_areas().any(func(a): a.owner is PuzRail)
	Area.area_entered.connect(CheckGetOnRail)
	#Area.area_exited.connect(CheckGetOffRail)
	return

func CheckGetOnRail(node : Node2D):
	
	if(isOnRail):
		return
	if(node.owner is PuzRail):
		isOnRail = true
		global_position.y = node.global_position.y
		Facing = node.owner.RailDirection
		
	if(Facing == RailDir.EastWest):
		global_position.y = node.global_position.y
	else:
		global_position.x = node.global_position.x +16
		pass
		
		
	print("isOnRail:" + str(isOnRail))
	return
	
func CheckGetOffRail(node : Node2D):
	if(not isOnRail):
		return
	if(node.owner is PuzRail):
		isOnRail = false
	print("isOnRail:" + str(isOnRail))
	return


#func _draw() -> void:
	#var nearest
	#var distToRail : float = INF
	#for area in Area.get_overlapping_areas().filter(func(a): return a.owner is PuzRail):
		#var rail = area.owner as PuzRail
		#if(to_local(global_position).distance_to(to_local(rail.global_position)) < distToRail):
			#distToRail = to_local(global_position).distance_to(to_local(rail.global_position))
			#nearest = rail
	#if(nearest):
		#draw_line(to_local(global_position), to_local(nearest.global_position), Color.GREEN)
