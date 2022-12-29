class_name PlayerSprite
extends AnimatedSprite2D

#func _on_player_animate(motion):
#	if motion.y < 0:
#		play("jump")
#	elif motion.x > 0:
#		flip_h = false
#		play("run")
#	elif motion.x < 0:
#		flip_h = true
#		play("run")
#	else:
#		play("idle")
