extends Node2D

# Reference to the NPC to give it commands.
@onready var npc: NPC = $NPC


# This special Godot function processes input like mouse clicks.
func _unhandled_input(event: InputEvent) -> void:
	# Check if the input was a mouse button press.
	if event is InputEventMouseButton:
		
		# Check if it was the LEFT mouse button that was just pressed down.
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			
			# Get the global position of the mouse click in the game world.
			var click_position: Vector2 = get_global_mouse_position()
			
			# Call the function to move the NPC, telling it where to move.
			npc.order_to_move(click_position)
			
			# Tells Godot this has "handled" this click.
			get_viewport().set_input_as_handled()
