class_name NPC
extends CharacterBody2D


# The speed of the NPC
@export var speed: float = 100.0

#TTDG: Doors use this array to check to make sure the AI can pass.
var CollectedKeys : Array = []
#TTDG: Publicize the want to go direction for minecarts.
var WalkDir : Vector2 = Vector2.ZERO

# A reference to the NavigationAgent2D node. Get this in _ready().
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
# A reference to the node that handles all animations.
@onready var animation_player: AnimationPlayer = $AnimationPlayer
# A reference to the timer for randomizing idle animations.
@onready var helmet_timer: Timer = $Timer
# A reference to the sprite node that contains the helmet animations.
@onready var animated_sprite: AnimatedSprite2D = $SpriteContainer/AnimatedSprite2D
# A reference to the container for the sprite to allow bobbing without moving collision.
@onready var sprite_container: Node2D = $SpriteContainer

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
	# Connect the timer's timeout signal to the function that handles the helmet close.
	helmet_timer.timeout.connect(_on_helmet_timer_timeout)
	# This call ensures the NPC starts in the proper idle state with animations running.
	_on_navigation_finished()


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
				WalkDir = global_position.direction_to(next_path_position)
				
				# Set velocity to move in that direction and normalize it.
				velocity = WalkDir.normalized() * speed
			else:
				# If we've somehow reached here but the signal hasn't fired, stop.
				velocity = Vector2.ZERO
	
	# This function actually moves the character based on its velocity.
	move_and_slide()


# This is the modular function the dialogue system will call.
# It gives the AI an order to move to a specific global position.
func order_to_move(target_position: Vector2) -> void:
	# Reset the sprite container's position in case it was in the middle of a bob.
	sprite_container.position = Vector2.ZERO
	# Stop the timer that triggers the helmet close.
	helmet_timer.stop()
	
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
	# Play the looping bob animation.
	animation_player.play("bob_idle")
	# Start the timer to check for the helmet animation.
	helmet_timer.start()


# This function is called when the helmet_timer finishes its countdown.
func _on_helmet_timer_timeout() -> void:
	# Sets the timer for the next check to a random duration between 7 and 10 seconds.
	helmet_timer.wait_time = randf_range(7.0, 10.0)
	
	# Gives a 50% chance to trigger the helmet close animation.
	if randf() < 0.5:
		# Calls the async function to play the sequence.
		_play_helmet_close_sequence()


# This async function handles playing the helmet animation and then returning to idle.
func _play_helmet_close_sequence() -> void:

	# Reset the bob position for a clean animation.
	sprite_container.position = Vector2.ZERO
	
	# Set the AnimatedSprite2D to play the 'helmet_closed' animation.
	animated_sprite.play("helmet_closed")
	
	# Create an in-line timer and wait for 1 second for the animation to be visible.
	await get_tree().create_timer(4.0).timeout
	
	# Set the AnimatedSprite2D back to the 'helmet_open' animation.
	animated_sprite.play("helmet_open")
	
	# This checks if the AI is still idle after the animation. If an order
	# was given during the helmet close, it should not start bobbing again.
	if current_state == State.IDLE:
		# If still idle, resume the bobbing animation.
		animation_player.play("bob_idle")
