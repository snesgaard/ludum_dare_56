extends RigidBody3D

@onready var step_sound = $step_sound

func initialize(spawn_position: Vector3):
	self.position = spawn_position

func _body_entered(other: Node) -> void:
	step_sound.play()
	Score.handle_collision(self, other)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.contact_monitor = true
	self.max_contacts_reported = 1000
	body_entered.connect(_body_entered, 0)

var input_dir = {
	"move_forward": Vector3.FORWARD,
	"move_backward": Vector3.BACK,
	"move_left": Vector3.LEFT,
	"move_right": Vector3.RIGHT
}

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for key in input_dir:
		var v = input_dir[key]
		var input = Input.get_action_strength(key)
		apply_central_force(input * v * 1000.0 * delta)
