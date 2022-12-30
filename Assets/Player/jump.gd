extends BaseState

@export var fall_gravity_multiplier: float = 2.0

func enter(last_state: int) -> void:
	# This calls the base class enter function, which is necessary here
	# to make sure the animation switches
	super.enter(last_state)
	player.velocity.y = player.jump_force * -1
	
func input(event: InputEvent) -> int:
	if last_state != State.Dash and Input.is_action_just_pressed("dash"):
		return State.Dash
	return State.Null

func physics_process(delta: float) -> int:
	player.move = 0
	if Input.is_action_pressed("left"):
		player.move = -1
		player.animations.flip_h = true
	elif Input.is_action_pressed("right"):
		player.move = 1
		player.animations.flip_h = false
		
	if Input.is_action_just_released("jump"):
		player.velocity.y *= 0.5
	
	player.velocity.x = player.move * player.move_speed
	player.velocity.y += player.gravity * delta
	player.move_and_slide()
	
	if player.velocity.y > -(player.jump_falloff):
		return State.Fall

	if player.is_on_floor():
		if player.move != 0:
			return State.Run
		else:
			return State.Idle
	return State.Null
