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
	var move_x := Input.get_axis("move_left","move_right")
	var move_z := Input.get_axis("move_backwards","move_forwards")
	direction.x = move_x
	direction.z = move_z
	if direction.x != 0:
		velocity.x = direction.x + speed
	else:
		velocity.x = 0
	if direction.z != 0:
		velocity.z = direction.y + speed
	else:
		velocity.z = 0
	move_and_slide()
