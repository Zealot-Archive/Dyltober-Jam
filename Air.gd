extends State
class_name PlayerAir
@onready var player = stateowner

# Called when the node enters the scene tree for the first time.
func enter():
	pass

func handle_input(event):
	pass
	
func get_gravity():
	return player.jump_gravity if player.velocity.y < 0.0 else player.fall_gravity

func state_physics_process(delta):
	player.input_direction_x = -1 * (Input.get_action_strength("move left") - Input.get_action_strength("move right"))
	player.currentspeed += player.Acceleration
	player.velocity.y += get_gravity() * delta

	if player.input_direction_x > 0:
		player.children.PlayerSprite.flip_h = false
	elif player.input_direction_x < 0:
		player.children.PlayerSprite.flip_h = true

#	if player.children.Left.is_colliding() || player.children.Right.is_colliding():
#		print ("Test")
#		Transitioned.emit(self, "WallHang")

	if player.is_on_floor() && Input.is_action_just_pressed("jump"):
		player.children.AnimationPlayer.play("Jump")
		player.velocity.y = player.jump_velocity
		player.DoMovement()

	else:
		player.children.AnimationPlayer.play("Fall")


	if player.is_on_floor():
		Transitioned.emit(self, "Idle")

func state_process(delta):
	pass
