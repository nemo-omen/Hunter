extends BaseState

func input(event: InputEvent) -> int:
	if Input.is_action_just_pressed("left") or Input.is_action_just_pressed("right"):
		return State.Run
	elif Input.is_action_just_pressed("jump"):
		return State.Jump
	elif Input.is_action_just_pressed("dash"):
		return State.Dash
	return State.Null

func physics_process(delta: float) -> int:
	player.velocity.y += player.gravity
	player.move_and_slide()

	if !player.is_on_floor():
		return State.Fall
	return State.Null
