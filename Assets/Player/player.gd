class_name Player
extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var jump_force: float = 860
@export var jump_falloff: float = 300
@export var move_speed: float = 600.0
@export var dash_speed: float = 1200.0
@export var mass: float = 5.0

# later, when the player becomes more powerful
# this can be set higher so they can control how
# quickly they fall by pressing down
@export var force_down_multiplier: float = 1

@onready var animations = $animations
@onready var states = $state_manager
@onready var dash_particles = $dash_particles
var move: int = 0

signal animate
signal peek
signal camreset

func _ready() -> void:
	states.init(self)
	print(ProjectSettings.get_setting('physics/common/physics_ticks_per_second'))
	print(dash_particles)
func _unhandled_input(event: InputEvent) -> void:
	states.input(event)

func _physics_process(delta: float) -> void:
	states.physics_process(delta)
	_peek()
	cam_reset()

func direction() -> int:
	if $animations.flip_h == true:
		return -1
	else:
		return 1
	
func _peek():
	if Input.is_action_pressed("rightarrow") and not Input.is_action_pressed("downarrow") and not Input.is_action_pressed("uparrow"):
		emit_signal("peek", "right")
	elif Input.is_action_pressed("leftarrow") and not Input.is_action_pressed("downarrow") and not Input.is_action_pressed("uparrow"):
		emit_signal("peek", "left")
	elif Input.is_action_pressed("uparrow") and not Input.is_action_pressed("rightarrow") and not Input.is_action_pressed("leftarrow"):
		emit_signal("peek", "up")
	elif Input.is_action_pressed("downarrow") and not Input.is_action_pressed("rightarrow") and not Input.is_action_pressed("leftarrow"):
		emit_signal("peek", "down")
	elif Input.is_action_pressed("rightarrow") and Input.is_action_pressed("downarrow"):
		emit_signal("peek", "downright")
	elif Input.is_action_pressed("rightarrow") and Input.is_action_pressed("uparrow"):
		emit_signal("peek", "upright")
	elif Input.is_action_pressed("leftarrow") and Input.is_action_pressed("downarrow"):
		emit_signal("peek", "downleft")
	elif Input.is_action_pressed("leftarrow") and Input.is_action_pressed("uparrow"):
		emit_signal("peek", "upleft")

func cam_reset():
	if is_on_floor():
		if not Input.is_action_pressed("right") and not Input.is_action_pressed("left") and not Input.is_action_pressed("uparrow") and not Input.is_action_pressed("downarrow"):
			emit_signal('camreset')
