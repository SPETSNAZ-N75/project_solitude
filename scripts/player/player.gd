extends CharacterBody3D

@export var speed = 100
@export var fall_accel = 75
@export var jump_height = 10
var direction = Vector3.ZERO
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	# set input start
	var move_x = Input.get_axis("move_left","move_right")
	var move_z = Input.get_axis("move_forwards","move_backwards")
	# set input end 
	
	direction = Vector3(move_x,0.0,move_z).normalized()
	velocity = direction * speed
	#print(velocity , direction)
	move_and_slide()
