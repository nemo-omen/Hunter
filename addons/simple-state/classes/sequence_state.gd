class_name SequenceState
extends State
@icon("../icons/sequence_state.png")


@export_range(0, 20, 1, "or_greater")
## How many times the sequence should be looped through before emitting [signal State.choose_new_substate_requested].
## [b]If set to zero, it will go forever.[/b]
var loops := 1


var _loops_left := 0


# Called when the state is activated. (parents, then children)
func _enter() -> void:
	pass


# Called after the state is activated. (children, then parents)
func _after_enter() -> void:
	pass


# Called every physics frame (only when the state is active, of course). (parents, then children)
func _update(delta: float) -> void:
	pass


# Called at the end of every physics frame. (children, then parents)
func _after_update(delta: float) -> void:
	pass


# Called before the state is deactivated. (parents, then children)
func _before_exit() -> void:
	pass


# Called when the state is deactivated. (children, then parents)
func _exit() -> void:
	pass


# You can define which state is picked automatically (like on [method enter]).
# If you would like to call it yourself, use the public version ([method choose_substate]).
func _choose_substate() -> State:
	if _active_substate == null:
		return get_child(0) if get_child_count() > 0 else null
	
	if _active_substate.get_index() == get_child_count() - 1:
		if loops == 0:
			return get_child(0)
		elif _loops_left == 0:
			choose_new_substate_requested.emit()
			return null
		else:
			_loops_left -= 1
			return get_child(0)
	return get_child(_active_substate.get_index() + 1)


func enter(set_target: Node, set_animation_player : AnimationPlayer, set_debug := false) -> void:
	super(set_target, set_animation_player, set_debug)
	_loops_left = loops - 1
