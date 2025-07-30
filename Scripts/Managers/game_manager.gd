# res://Scripts/game_manager.gd
extends Node2D

# We need a reference to the NPC to give it commands.
# The '@' symbol means it will get the node named "NPC"
# which is a child of this "Game" node.
@onready var npc: NPC = $NPC


# This special Godot function processes input like mouse clicks.
func _unhandled_input(event: InputEvent) -> void:
	# We check if the input was a mouse button press.
	if event is InputEventMouseButton:
		
		# We check if it was the LEFT mouse button that was just pressed down.
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			
			# Get the global position of the mouse click in the game world.
			var click_position: Vector2 = get_global_mouse_position()
			
			# Call the function we created on our NPC, telling it where to move.
			npc.order_to_move(click_position)
			
			# This tells Godot we've "handled" this click.
			get_viewport().set_input_as_handled()
