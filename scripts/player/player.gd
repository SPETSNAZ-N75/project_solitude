extends CharacterBody3D

@onready var fp_cam: Camera3D = $FPCam
@onready var arms: Node3D = $FPCam/arms
@onready var anim_player: AnimationPlayer = $FPCam/arms/AnimationPlayer2

@export var speed = 100
@export var fall_accel = 75
@export var jump_height = 10
@export var mouse_sens = 0.5
var direction = Vector3.ZERO
var bmouse_captured = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	anim_player.play("AnimLib_1/Idle")
	
func _unhandled_input(event: InputEvent) -> void:
	#Camera movement
	if event is InputEventMouseMotion && bmouse_captured:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		fp_cam.rotate_x(deg_to_rad(-event.relative.y * mouse_sens))
		fp_cam.rotation_degrees.x = clamp(fp_cam.rotation_degrees.x, -90 , 90)

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
	#movement input
	var move_direction = Input.get_vector("move_left","move_right","move_forwards","move_backwards")
	direction = (transform.basis * Vector3(move_direction.x, 0, move_direction.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		anim_player.play("AnimLib_1/walk")
	else:
		velocity.x = move_toward(velocity.x,0,speed)
		velocity.z = move_toward(velocity.z,0,speed)
		anim_player.play("AnimLib_1/Idle")
	move_and_slide()
