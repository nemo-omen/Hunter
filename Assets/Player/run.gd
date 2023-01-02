extends BaseState

func input(event: InputEvent) -> int:
	if Input.is_action_just_pressed("jump"):
		return State.Jump
	
	if last_state != State.Dash and Input.is_action_just_pressed("dash"):
		return State.Dash

	return State.Null

func physics_process(delta: float) -> int:
	if !player.is_on_floor():
		return State.Fall

	player.move = 0
	if Input.is_action_pressed("left"):
		player.move = -1
		player.animations.flip_h = true
	elif Input.is_action_pressed("right"):
		player.move = 1
		player.animations.flip_h = false
	
	player.velocity.y += (player.gravity * delta) * player.mass
	player.velocity.x = player.move * player.move_speed
	player.move_and_slide()
	
	
	if player.move == 0:
		return State.Idle

	return State.Null
