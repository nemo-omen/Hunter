extends Node

@onready var states = {
	BaseState.State.Null: null,
	BaseState.State.Idle: $idle,
	BaseState.State.Run: $run,
	BaseState.State.Fall: $fall,
	BaseState.State.Jump: $jump,
}

# hold on to the current state
var current_state: BaseState

# hold on to the last state
var last_state: BaseState

# store last state as integer so we can pass
# to next state when we transition to it
var last_state_int: int = 0

func change_state(new_state: int) -> void:
	if current_state:
		current_state.exit()
	
	# Before changing state, we store the last state
	last_state = current_state
	current_state = states[new_state]
	
	# We can get the integer value of the state's
	# enum key
	if states.find_key(last_state) != null:
		last_state_int = states.find_key(last_state)
	
	# Pass the integer value of the last state
	# to the state we're transitioning to
	current_state.enter(last_state_int)

# Initialize the state machine by giving each state a reference to the objects
# owned by the parent that they should be able to take control of
# and set a default state
func init(player: Player) -> void:
	for child in get_children():
		child.player = player

	# Initialize with a default state of idle
	change_state(BaseState.State.Idle)
	
# Pass through functions for the Player to call,
# handling state changes as needed
func physics_process(delta: float) -> void:
	var new_state = current_state.physics_process(delta)
	if new_state != BaseState.State.Null:
		change_state(new_state)

func input(event: InputEvent) -> void:
	var new_state = current_state.input(event)
	if new_state != BaseState.State.Null:
		change_state(new_state)
