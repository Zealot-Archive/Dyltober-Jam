extends State
class_name PlayerWallHang
@onready var player = stateowner

@export var jump_height : float
@export var jump_time_to_peak : float
@export var jump_time_to_descent : float

@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

var ChangeBuffer = 400
var LastJumpPressed : int
var hasJumped = false
var JumpDirection = 0
var LastJumpDirection = 1
var hasLeftWall = func(): return (hasJumped && (ChangeBuffer + LastJumpPressed) < Time.get_ticks_msec()) 

# Called when the node enters the scene tree for the first time.
func enter():
	LastJumpPressed = Time.get_ticks_msec()
	LastJumpDirection = 0
	hasJumped = false

func handle_input(event):
	pass
	
func get_gravity():
	return jump_gravity if player.velocity.y < 0.0 else fall_gravity

func state_physics_process(delta):
	player.velocity.y += get_gravity() * delta
	player.MaxSpeed = player.BaseSpeed * 2.5
	
	if player.children.Left.is_colliding() && player.is_on_wall():
		player.input_direction_x = -1
		player.children.PlayerSprite.flip_h = false
		if LastJumpDirection != player.input_direction_x && hasJumped:
			player.currentspeed = 0
		JumpDirection = player.input_direction_x
	
	elif player.children.Right.is_colliding() && player.is_on_wall():
		player.input_direction_x = 1
		player.children.PlayerSprite.flip_h = true
		if LastJumpDirection != player.input_direction_x && hasJumped:
			player.currentspeed = 0
		JumpDirection = player.input_direction_x
	
	else:
		Transitioned.emit(self, "Air")
	
	if Input.is_action_just_pressed("jump") && JumpDirection != LastJumpDirection :
		hasJumped = true
		LastJumpPressed = Time.get_ticks_msec()
		player.children.AnimationPlayer.play("Jump")
		player.velocity.y = jump_velocity / 1.5
		player.currentspeed = jump_velocity
		player.DoMovement()
		print ("Walljump")
		LastJumpDirection = JumpDirection
	
#	if hasLeftWall.call():
#		Transitioned.emit(self, "Air")
	
	if player.is_on_floor():
		hasJumped = false
		LastJumpDirection = 0
		Transitioned.emit(self, "idle")
	
func state_process(delta):
	pass
