class_name Player
extends CharacterBody2D

@export var Acceleration : int
@onready var input_direction_x : float
@export var BaseSpeed : int

@export var jump_height : float
@export var jump_time_to_peak : float
@export var jump_time_to_descent : float

@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

var MaxSpeed : int
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var children : Dictionary = {}
var currentspeed = 0.0

@onready var states = $State_Manager
#@onready var Animations = $AnimationPlayer

func _ready() -> void:
	for child in get_children():
		children[child.name] = child
	
#func _unhandled_input(event: InputEvent) -> void:
#	states.handle_input(event)
	
func _physics_process(delta: float) -> void:
	states._physics_process(delta)
	DoMovement()

func DoMovement():
	currentspeed = clamp(currentspeed, -MaxSpeed, MaxSpeed)
	velocity.x = (input_direction_x * currentspeed)
	move_and_slide()
