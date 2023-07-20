extends State
class_name PlayerRun
@onready var player = stateowner

var RunMultiplier = 2.5

# Called when the node enters the scene tree for the first time.
func enter():
	player.children.AnimationPlayer.play(animation_name)

func handle_input(event):
	pass

func state_physics_process(delta):
	player.input_direction_x = -1 * (Input.get_action_strength("move left") - Input.get_action_strength("move right"))
	if !stateowner.is_on_floor() || Input.is_action_just_pressed("jump"):
		Transitioned.emit(self, "Air")
		return
	
	if !Input.is_action_pressed("run"):
		Transitioned.emit(self, "Walk")

	if player.input_direction_x > 0:
		player.children.PlayerSprite.flip_h = false
	elif player.input_direction_x < 0:
		player.children.PlayerSprite.flip_h = true
	
	player.velocity.y = player.gravity * delta
	player.MaxSpeed = (player.BaseSpeed * RunMultiplier)
	player.currentspeed += (player.Acceleration * RunMultiplier)

	if is_equal_approx(player.input_direction_x, 0.0):
		Transitioned.emit(self, "Idle")

func state_process(delta):
	pass
