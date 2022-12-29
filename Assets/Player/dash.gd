extends BaseState

@export var dash_time: float =0.6
var dash_timer: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func enter(last_state: int) -> void:
	super.enter(last_state)
	dash_timer = dash_time
	player.velocity.y = 0
	player.move = player.direction()

func input(event: InputEvent) -> int:
	return State.Null


# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_process(delta) -> int:
	dash_timer -= delta

	if player.move == -1:
		player.animations.flip_h = true
	elif player.move == 1:
		player.animations.flip_h = false

	player.velocity.x = player.move * player.dash_speed
	player.move_and_slide()
	
	if dash_timer <= 0:
		if player.is_on_floor():
			if player.move != 0:
				return State.Run
			else:
				return State.Idle
		else:
			return State.Fall
	return State.Null
