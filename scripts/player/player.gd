extends CharacterBody3D
@onready var fp_cam: Camera3D = $FPCam

@export var speed = 100
@export var fall_accel = 75
@export var jump_height = 10
var direction = Vector3.ZERO
var bmouse_captured = true
@export var mouse_sens = .05
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion && bmouse_captured:
		rotate_y(event.relative.x * mouse_sens)
		fp_cam.rotate_x(event.relative.y * mouse_sens)
func _input(event):
	
	#mouse_capture toggle
	if event.is_action_pressed("Pause"):
		if bmouse_captured:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			bmouse_captured = false
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			bmouse_captured = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	# set movement input
	var move_x = Input.get_axis("move_left","move_right")
	var move_z = Input.get_axis("move_forwards","move_backwards")

	
	direction = Vector3(move_x,0.0,move_z).normalized()
	velocity = direction * speed
	#print(velocity , direction)
	move_and_slide()
