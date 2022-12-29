extends BaseState

@export  var jump_buffer: float = 0.2
@export var coyote_time: float = 0.1

var buffer_timer: float = 0.0
var coyote_timer: float = 0.0

var fall_multiplier: float = 3.0

func enter(last_state: int) -> void:
	super.enter(last_state)
	buffer_timer = 0.0
	if last_state == State.Run:
		coyote_timer = coyote_time
	else:
		coyote_timer = 0.0

func input(event: InputEvent) -> int:
	if Input.is_action_just_pressed('jump'):
		buffer_timer = jump_buffer
	return State.Null

func physics_process(delta: float) -> int:
	buffer_timer -= delta
	coyote_timer -= delta
	
	var move = 0
	if Input.is_action_pressed("left"):
		move = -1
		player.animations.flip_h = true
	elif Input.is_action_pressed("right"):
		move = 1
		player.animations.flip_h = false
	
	player.velocity.x = move * player.move_speed
	player.velocity.y += (player.gravity * delta) * fall_multiplier
	player.move_and_slide()

	if player.is_on_floor():
		if buffer_timer > 0:
			return State.Jump
		
		if move != 0:
			return State.Run
		else:
			return State.Idle
	else:
		if Input.is_action_just_pressed("jump"):
			if coyote_timer > 0:
				return State.Jump
	return State.Null
