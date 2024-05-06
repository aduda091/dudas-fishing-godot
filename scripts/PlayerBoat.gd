extends CharacterBody2D


const SPEED = 100.0 # TODO: read from GameManager to use engine upgrades
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var sprite2DBoat = $Katarina
@onready var sprite2DFisherman = $Mateo


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	var direction = Input.get_axis("move_left", "move_right")
	
	var isFishing = Input.is_action_pressed("cast_down") || Input.is_action_pressed("cast_up")

	# Handle fishing.
	if isFishing:
		sprite2DFisherman.play("fishing")
		sprite2DFisherman.position.y = -26
	
	if direction > 0 && !isFishing:
		sprite2DBoat.flip_h = false
		sprite2DFisherman.flip_h = false
		sprite2DFisherman.play("rowing")
		sprite2DFisherman.position.y = -10
	if direction < 0 && !isFishing:
		sprite2DBoat.flip_h = true
		sprite2DFisherman.flip_h = true
		sprite2DFisherman.play("rowing")
		sprite2DFisherman.position.y = -10
		
	if direction == 0 && !isFishing:
		sprite2DFisherman.play("idle")
		sprite2DFisherman.position.y = -26
		
	if direction && !isFishing:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
