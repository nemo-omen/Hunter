extends BaseState

@export var fall_gravity_multiplier: float = 2.0

func enter(last_state: int) -> void:
	# This calls the base class enter function, which is necessary here
	# to make sure the animation switches
	super.enter(last_state)
	player.velocity.y = player.jump_force * -1
	
func physics_process(delta: float) -> int:
	var move = 0
	if Input.is_action_pressed("left"):
		move = -1
		player.animations.flip_h = true
	elif Input.is_action_pressed("right"):
		move = 1
		player.animations.flip_h = false
		
	if Input.is_action_just_released("jump"):
		player.velocity.y *= 0.5
	
	player.velocity.x = move * player.move_speed
	player.velocity.y += player.gravity * delta
	player.move_and_slide()
	
	if player.velocity.y > 0:
		return State.Fall

	if player.is_on_floor():
		if move != 0:
			return State.Run
		else:
			return State.Idle
	return State.Null
