@tool
extends EditorPlugin


var state_icon := load("res://addons/simple-state/icons/state.png") as Texture2D
var random_state_icon := load("res://addons/simple-state/icons/random_state.png") as Texture2D
var animation_state_icon := load("res://addons/simple-state/icons/animation_state.png") as Texture2D
var sequence_state_icon := load("res://addons/simple-state/icons/sequence_state.png") as Texture2D


func _enter_tree() -> void:
	add_custom_type("State", "Node", State, state_icon)
	add_custom_type("RandomState", "State", RandomState, random_state_icon)
	add_custom_type("AnimationState", "State", AnimationState, animation_state_icon)
	add_custom_type("SequenceState", "State", SequenceState, sequence_state_icon)


func _exit_tree() -> void:
	remove_custom_type("State")
	remove_custom_type("RandomState")
	remove_custom_type("AnimationState")
	remove_custom_type("SequenceState")
