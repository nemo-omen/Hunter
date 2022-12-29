extends BaseState

func input(event: InputEvent) -> int:
	if Input.is_action_just_pressed("jump"):
		return State.Jump
	return State.Null

func physics_process(delta: float) -> int:
	if !player.is_on_floor():
		return State.Fall

	var move = 0
	if Input.is_action_pressed("left"):
		move = -1
		player.animations.flip_h = true
	elif Input.is_action_pressed("right"):
		move = 1
		player.animations.flip_h = false
	
	player.velocity.y += player.gravity
	player.velocity.x = move * player.move_speed
	player.move_and_slide()
	
	if move == 0:
		return State.Idle

	return State.Null
