class_name NPC
extends CharacterBody2D


# The speed of the NPC
@export var speed: float = 100.0

#TTDG: Doors use this array to check to make sure the AI can pass.
var CollectedKeys : Array = []

# A reference to the NavigationAgent2D node. Get this in _ready().
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

# This enum defines the possible states the AI can be in.
enum State {
	IDLE,
	MOVING,
	# TODO add more later like INTERACTING or CONFUSED.
}

# This variable holds the AI's current state. It starts as IDLE.
var current_state: State = State.IDLE


# _ready() is called once when the node enters the scene tree.
func _ready() -> void:
	# Connect the navigation_finished signal from the agent to our own function.
	# This is the "Godot way" to know when the AI has arrived at its destination.
	navigation_agent.navigation_finished.connect(_on_navigation_finished)


# _physics_process() is called every physics frame. Ideal for movement and state logic.
func _physics_process(_delta: float) -> void:
	# A 'match' statement is a clean way to handle different states.
	# It's like a switch statement in other languages.
	match current_state:
		State.IDLE:
			# When idle, do nothing. Stop all movement.
			velocity = Vector2.ZERO
		
		State.MOVING:
			# If we are not at the final destination yet...
			if not navigation_agent.is_navigation_finished():
				# Get the next point on the calculated path.
				var next_path_position: Vector2 = navigation_agent.get_next_path_position()
				
				# Calculate the direction from our current position to the next point.
				var direction: Vector2 = global_position.direction_to(next_path_position)
				
				# Set velocity to move in that direction and normalize it.
				velocity = direction.normalized() * speed
			else:
				# If we've somehow reached here but the signal hasn't fired, stop.
				velocity = Vector2.ZERO
	
	# This function actually moves the character based on its velocity.
	move_and_slide()


# This is the modular function the dialogue system will call.
# It gives the AI an order to move to a specific global position.
func order_to_move(target_position: Vector2) -> void:
	# Tell the navigation agent where to go. It will calculate the path automatically.
	navigation_agent.target_position = target_position
	
	# Change the AI's state to MOVING so the logic in _physics_process kicks in.
	current_state = State.MOVING
	print("NPC ordered to move to: ", target_position)


# This function is called automatically when the navigation_agent reaches its destination.
func _on_navigation_finished() -> void:
	print("NPC has arrived at destination.")
	# Now that we've arrived, go back to the IDLE state and wait for the next command.
	current_state = State.IDLE
