extends RigidBody3D

@onready var move_timer = $Timer
@onready var meow_sound = $meow_sound

@export var force: float = 500
@export var force_step: float = 50
@export var min_force: float = 500
@export var max_force: float = 3000

@onready var meow_audio = [
	$meow_damp,
	$meow_long,
	$meow_sound
]

var meow_audio_index: int = 0

func initialize(spawn_position: Vector3):
	self.position = spawn_position
	
func _on_force_change(c: float) -> void:
	force = clamp(force + c, min_force, max_force)

	
var rng = RandomNumberGenerator.new()

func _find_nearest_creature() -> Node:
	var group = "creature" if rng.randf_range(0.0, 1.0) > 0.2 else "powerup"
	var creatures = get_tree().get_nodes_in_group(group)
	var closest = null
	var dist = INF
	for c in creatures:
		var d = self.position.distance_squared_to(c.position)
		if d < dist:
			dist = d
			closest = c
	
	return closest 

func play_meow() -> void:
	if 0 <= meow_audio_index and meow_audio_index < meow_audio.size():
		var a = meow_audio[meow_audio_index]
		a.play()

func _move_forward() -> void:
	var target = _find_nearest_creature()
	if target == null:
		return

	var n = (target.position - self.position).normalized()
	apply_central_force(n * force)
	if force < max_force:
		force += force_step
	play_meow()
	#apply_torque_impulse(-n * force / 10)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	meow_audio_index = rng.randi_range(0, meow_audio.size() - 1)
	print("Selecting audio", meow_audio_index)
	move_timer.timeout.connect(_move_forward)
	Powerup.bad_guy_force_change.connect(_on_force_change)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
