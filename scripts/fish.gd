extends Node2D

var speed
var direction = 1
const fishes = ["fish1", "fish2", "fish3"]

@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var animated_sprite = $AnimatedSprite2D


func _ready():
	var random = RandomNumberGenerator.new()
	random.randomize()
	speed = random.randi_range(20, 80)
	
	var randomFishAnimation = fishes[randi() % fishes.size()]
	animated_sprite.play(randomFishAnimation)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# todo check for collider only for wall and player hook
	if (ray_cast_right.is_colliding()): 
		direction = -1
		animated_sprite.flip_h = true
	if (ray_cast_left.is_colliding()): 
		direction = 1
		animated_sprite.flip_h = false
	position.x += direction * speed * delta
