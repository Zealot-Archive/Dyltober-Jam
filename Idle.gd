extends State
class_name PlayerIdle
@onready var player = stateowner

# Called when the node enters the scene tree for the first time.
func enter():
	stateowner.children.AnimationPlayer.play(animation_name)

func handle_input(event):
	pass

func state_physics_process(delta):
	player.input_direction_x = -1 * (Input.get_action_strength("move left") - Input.get_action_strength("move right"))
	player.currentspeed = 0
	player.MaxSpeed = player.BaseSpeed
	
	player.velocity.y += player.fall_gravity * delta
	if Input.is_action_pressed("move left") or Input.is_action_pressed("move right"):
		Transitioned.emit(self, "Walk")
	if Input.is_action_just_pressed("jump"):
		Transitioned.emit(self, "Air")
	
func state_process(delta):
	pass
