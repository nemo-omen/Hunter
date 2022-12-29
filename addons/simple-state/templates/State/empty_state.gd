extends _BASE_


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
	return get_child(0) if get_child_count() else null
