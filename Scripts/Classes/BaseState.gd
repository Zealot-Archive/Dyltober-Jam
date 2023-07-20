extends Node2D
class_name State

signal Transitioned
var state_machine = null
@export var animation_name : String
@export var stateowner: CharacterBody2D

# Virtual function. Receives events from the `_unhandled_input()` callback.
func handle_input(event: InputEvent):
	pass

# Virtual function. Corresponds to the `_process()` callback.
func state_process(_delta: float):
	pass


# Virtual function. Corresponds to the `_physics_process()` callback.
func state_physics_process(_delta: float):
	pass


# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter():
	pass

# Virtual function. Called by the state machine before changing the active state. Use this function
# to clean up the state.
func exit():
	pass
