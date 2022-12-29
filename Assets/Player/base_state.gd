class_name BaseState
extends Node

enum State {
	Null,
	Idle,
	Run,
	Fall,
	Jump
}

@export var animation_name: String
var last_state: int = State.Null

var player: Player

func enter(previous_state: int) -> void:
	player.animations.play(animation_name)
	last_state = previous_state

func exit() -> void:
	pass

func input(event: InputEvent) -> int:
	return State.Null

func process(delta: float) -> int:
	print('process...')
	return State.Null

func physics_process(delta: float) -> int:
	return State.Null
