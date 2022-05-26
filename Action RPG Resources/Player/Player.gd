extends KinematicBody2D

var velocity = Vector2.ZERO
const ACCELERATION = 500
const MAX_SPEED = 80
const FRICTION = 500
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector =  input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		$AnimationTree.set("parameters/Idle/blend_position",input_vector)
		$AnimationTree.set("parameters/Run/blend_position",input_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED,ACCELERATION*delta)		
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO,FRICTION*delta)
	print(velocity)
	velocity = move_and_slide(velocity)
